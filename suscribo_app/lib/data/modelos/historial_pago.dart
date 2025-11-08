import 'package:isar/isar.dart';

import 'recurring_payment.dart';

part 'historial_pago.g.dart';

/// Registro histórico que documenta un pago marcado como realizado.
@collection
class HistorialPago {
  HistorialPago({
    required this.pagoId,
    required this.nombre,
    required this.montoPagado,
    required this.fechaRegistro,
    required this.tipoPago,
    required this.cicloPago,
  });

  /// Identificador único del registro generado por Isar.
  Id id = Isar.autoIncrement;

  /// Identificador del pago recurrente al que pertenece el registro.
  int pagoId;

  /// Nombre del pago en el momento en que se registró.
  String nombre;

  /// Monto confirmado que se pagó.
  double montoPagado;

  /// Fecha exacta en la que se marcó como pagado.
  DateTime fechaRegistro;

  /// Tipo del pago para facilitar reportes futuros.
  @Enumerated(EnumType.name)
  TipoPago tipoPago;

  /// Ciclo vigente al momento de registrar el pago.
  @Enumerated(EnumType.name)
  CicloPago cicloPago;
}

