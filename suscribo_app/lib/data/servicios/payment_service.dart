import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../modelos/historial_pago.dart';
import '../modelos/recurring_payment.dart';
import 'servicio_notificaciones.dart';

/// Proveedor encargado de exponer el Future que inicializa la base de datos Isar.
final isarProvider = Provider<Future<Isar>>((ref) {
  final futuro = _abrirIsar();
  ref.onDispose(() {
    futuro.then((isar) {
      if (isar.isOpen) {
        unawaited(isar.close());
        debugPrint('Instancia de Isar cerrada desde isarProvider.');
      }
    });
  });
  return futuro;
});

/// Proveedor que expone el servicio de pagos con acceso a la base de datos y notificaciones.
final servicioPagosProvider = Provider<ServicioPagos>((ref) {
  final isarFuture = ref.watch(isarProvider);
  final servicioNotificaciones = ref.watch(servicioNotificacionesProvider);
  return ServicioPagos(isarFuture, servicioNotificaciones);
});

/// Proveedor que emite en tiempo real la lista de pagos almacenados.
final pagosStreamProvider = StreamProvider<List<PagoRecurrente>>((ref) {
  final servicio = ref.watch(servicioPagosProvider);
  return servicio.observarPagos();
});

/// Proveedor que emite el historial de pagos realizados.
final historialPagosStreamProvider = StreamProvider<List<HistorialPago>>((ref) {
  final servicio = ref.watch(servicioPagosProvider);
  return servicio.observarHistorialPagos();
});

/// Servicio centralizado para gestionar la persistencia y lógica de pagos recurrentes.
class ServicioPagos {
  ServicioPagos(this._isarFuture, this._servicioNotificaciones);

  final Future<Isar> _isarFuture;
  final ServicioNotificaciones _servicioNotificaciones;

  Future<Isar> get _isar => _isarFuture;

  /// Agrega un nuevo pago recurrente a la base de datos y programa su notificación.
  Future<void> agregarPago(PagoRecurrente pago) async {
    final isar = await _isar;
    await isar.writeTxn(() async {
      final id = await isar.pagoRecurrentes.put(pago);
      pago.id = id;
    });
    await _servicioNotificaciones.programarNotificacion(pago);
    debugPrint('Pago "${pago.nombre}" agregado y notificación programada.');
  }

  /// Actualiza un pago recurrente previamente almacenado y ajusta su notificación.
  Future<void> actualizarPago(PagoRecurrente pago) async {
    final isar = await _isar;
    await isar.writeTxn(() async {
      await isar.pagoRecurrentes.put(pago);
    });
    await _servicioNotificaciones.programarNotificacion(pago);
    debugPrint('Pago "${pago.nombre}" actualizado y notificación reprogramada.');
  }

  /// Elimina un pago recurrente identificado por su Id y cancela cualquier notificación asociada.
  Future<void> eliminarPago(Id id) async {
    final isar = await _isar;
    await isar.writeTxn(() async {
      await isar.pagoRecurrentes.delete(id);
    });
    await _servicioNotificaciones.cancelarNotificacion(id);
    debugPrint('Pago con Id $id eliminado y notificación cancelada.');
  }

  /// Marca un pago como realizado, recalcula la fecha de vencimiento y reprograma su notificación.
  Future<void> marcarComoPagado(
    PagoRecurrente pago, {
    double? montoPagado,
    String? numeroOperacion,
    String? metodoPago,
    String? rutaComprobante,
  }) async {
    final isar = await _isar;

    if (pago.monto == 0.0 && montoPagado != null) {
      pago.monto = montoPagado;
      debugPrint(
        'Monto actualizado para "${pago.nombre}" con el valor pagado: $montoPagado.',
      );
    }

    pago.proximaFechaPago =
        _calcularProximaFecha(pago.proximaFechaPago, pago.cicloPago);

    await isar.writeTxn(() async {
      await isar.pagoRecurrentes.put(pago);
      await isar.historialPagos.put(
        HistorialPago(
          pagoId: pago.id,
          nombre: pago.nombre,
          montoPagado: pago.monto,
          fechaRegistro: DateTime.now(),
          tipoPago: pago.tipoPago,
          cicloPago: pago.cicloPago,
          numeroOperacion: numeroOperacion,
          metodoPago: metodoPago,
          rutaComprobante: rutaComprobante,
        ),
      );
    });

    await _servicioNotificaciones.programarNotificacion(pago);

    debugPrint(
      'Pago "${pago.nombre}" marcado como realizado. '
      'Nuevo vencimiento: ${pago.proximaFechaPago.toIso8601String()}.',
    );
  }

  /// Observa en tiempo real la colección de pagos, ordenando por fecha más próxima.
  Stream<List<PagoRecurrente>> observarPagos() {
    return Stream.fromFuture(_isar).asyncExpand((isar) {
      final consulta = isar.pagoRecurrentes.where().sortByProximaFechaPago();
      return consulta.watch(fireImmediately: true);
    });
  }

  /// Observa el historial de pagos registrados, ordenado de más reciente a más antiguo.
  Stream<List<HistorialPago>> observarHistorialPagos() {
    return Stream.fromFuture(_isar).asyncExpand((isar) {
      final consulta = isar.historialPagos.where().sortByFechaRegistroDesc();
      return consulta.watch(fireImmediately: true);
    });
  }

  /// Calcula la siguiente fecha de vencimiento en función del ciclo del pago.
  DateTime _calcularProximaFecha(DateTime fechaActual, CicloPago ciclo) {
    switch (ciclo) {
      case CicloPago.SEMANAL:
        return fechaActual.add(const Duration(days: 7));
      case CicloPago.MENSUAL:
        return _agregarMeses(fechaActual, 1);
      case CicloPago.TRIMESTRAL:
        return _agregarMeses(fechaActual, 3);
      case CicloPago.ANUAL:
        return _agregarMeses(fechaActual, 12);
    }
  }

  DateTime _agregarMeses(DateTime fecha, int meses) {
    final totalMeses = fecha.month - 1 + meses;
    final nuevoAnio = fecha.year + totalMeses ~/ 12;
    final nuevoMes = totalMeses % 12 + 1;
    final ultimoDiaMes = _diasEnMes(nuevoAnio, nuevoMes);
    final nuevoDia = min(fecha.day, ultimoDiaMes);

    return DateTime(
      nuevoAnio,
      nuevoMes,
      nuevoDia,
      fecha.hour,
      fecha.minute,
      fecha.second,
      fecha.millisecond,
      fecha.microsecond,
    );
  }

  int _diasEnMes(int anio, int mes) {
    if (mes == 12) {
      return DateTime(anio + 1, 1, 0).day;
    }
    return DateTime(anio, mes + 1, 0).day;
  }
}

Future<Isar> _abrirIsar() async {
  if (Isar.instanceNames.isNotEmpty) {
    return Isar.getInstance()!;
  }

  final directorio = await getApplicationDocumentsDirectory();
  return Isar.open(
    [PagoRecurrenteSchema, HistorialPagoSchema],
    directory: directorio.path,
    inspector: false,
  );
}

