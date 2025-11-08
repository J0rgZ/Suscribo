import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../modelos/recurring_payment.dart';

/// Identificador del canal principal de notificaciones de pagos.
const String _canalPagosId = 'pagos_recurrentes';

/// Nombre descriptivo del canal de notificaciones utilizado en Android.
const String _canalPagosNombre = 'Recordatorios de pagos';

/// Descripción breve del uso del canal.
const String _canalPagosDescripcion =
    'Notificaciones para recordar pagos recurrentes antes de su vencimiento.';

/// Proveedor de Riverpod encargado de exponer el servicio de notificaciones
/// listo para ser inyectado en vistas o controladores.
final servicioNotificacionesProvider =
    Provider<ServicioNotificaciones>((ref) {
  final plugin = FlutterLocalNotificationsPlugin();
  final servicio = ServicioNotificaciones(plugin);
  ref.onDispose(servicio.dispose);
  return servicio;
});

/// Servicio responsable de inicializar y gestionar las notificaciones locales.
class ServicioNotificaciones {
  ServicioNotificaciones(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;
  bool _inicializado = false;
  bool _zonaHorariaInicializada = false;

  /// Inicializa el plugin de notificaciones asegurando permisos y canales.
  Future<void> _asegurarInicializacion() async {
    if (_inicializado) {
      return;
    }

    const configuracionAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const configuracionIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final configuracionInicializacion = InitializationSettings(
      android: configuracionAndroid,
      iOS: configuracionIOS,
    );

    await _plugin.initialize(
      configuracionInicializacion,
      onDidReceiveNotificationResponse: (response) {
        debugPrint('Notificación interactuada: ${response.payload}');
      },
      onDidReceiveBackgroundNotificationResponse: _manejarRespuestaBackground,
    );
    await _configurarZonaHoraria();
    await _crearCanalAndroid();
    await _solicitarPermisos();

    _inicializado = true;
    debugPrint('ServicioNotificaciones inicializado correctamente.');
  }

  /// Crea el canal de notificaciones requerido en Android.
  Future<void> _crearCanalAndroid() async {
    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin == null) {
      return;
    }

    const canal = AndroidNotificationChannel(
      _canalPagosId,
      _canalPagosNombre,
      description: _canalPagosDescripcion,
      importance: Importance.high,
    );

    await androidPlugin.createNotificationChannel(canal);
  }

  /// Solicita permisos de notificación en las plataformas que lo requieren.
  Future<void> _solicitarPermisos() async {
    if (Platform.isAndroid) {
      final androidPlugin = _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      await androidPlugin?.requestNotificationsPermission();
    }

    if (Platform.isIOS) {
      final iosPlugin = _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      await iosPlugin?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  /// Muestra inmediatamente una notificación con el contenido proporcionado.
  Future<void> mostrarNotificacion(String titulo, String mensaje) async {
    await _asegurarInicializacion();
    final detalles = _detallesNotificacion();
    await _plugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      titulo,
      mensaje,
      detalles,
    );
  }

  /// Programa una notificación futura para un pago recurrente específico.
  Future<void> programarNotificacion(PagoRecurrente pago) async {
    await _asegurarInicializacion();

    if (pago.id <= 0) {
      debugPrint(
        'No es posible programar la notificación para "${pago.nombre}" porque aún no tiene un Id asignado.',
      );
      return;
    }

    final fechaNotificacion = pago.proximaFechaPago
        .subtract(Duration(days: pago.diasNotificacion));
    final fechaProgramada = fechaNotificacion.isAfter(DateTime.now())
        ? fechaNotificacion
        : DateTime.now().add(const Duration(seconds: 10));

    debugPrint(
      'Programando notificación para "${pago.nombre}" el '
      '${fechaProgramada.toIso8601String()} (vencimiento ${pago.proximaFechaPago}).',
    );

    final detalles = _detallesNotificacion();
    await cancelarNotificacion(pago.id);

    final fechaProgramadaTz = tz.TZDateTime.from(fechaProgramada, tz.local);
    final fechaFormateada = DateFormat.yMMMMd('es')
        .add_Hm()
        .format(pago.proximaFechaPago.toLocal());

    await _plugin.zonedSchedule(
      pago.id,
      'Recordatorio de pago: ${pago.nombre}',
      'Tu pago vence el $fechaFormateada',
      fechaProgramadaTz,
      detalles,
      payload: pago.nombre,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  /// Cancela la notificación asociada a un identificador concreto.
  Future<void> cancelarNotificacion(int id) async {
    await _asegurarInicializacion();
    await _plugin.cancel(id);
    debugPrint('Notificación cancelada para Id: $id');
  }

  /// Retorna los detalles comunes a todas las notificaciones de la aplicación.
  NotificationDetails _detallesNotificacion() {
    const detallesAndroid = AndroidNotificationDetails(
      _canalPagosId,
      _canalPagosNombre,
      channelDescription: _canalPagosDescripcion,
      importance: Importance.high,
      priority: Priority.high,
    );

    const detallesDarwin = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    return const NotificationDetails(
      android: detallesAndroid,
      iOS: detallesDarwin,
      macOS: detallesDarwin,
    );
  }

  /// Libera recursos internos cuando el proveedor deja de estar activo.
  void dispose() {
    debugPrint('ServicioNotificaciones liberado.');
  }

  Future<void> _configurarZonaHoraria() async {
    if (_zonaHorariaInicializada) {
      return;
    }

    tz.initializeTimeZones();
    if (kIsWeb) {
      tz.setLocalLocation(tz.getLocation('Etc/UTC'));
      _zonaHorariaInicializada = true;
      return;
    }

    try {
      if (Platform.isAndroid || Platform.isIOS) {
        final infoZona = await FlutterTimezone.getLocalTimezone();
        tz.setLocalLocation(tz.getLocation(infoZona.identifier));
        debugPrint('Zona horaria configurada en ${infoZona.identifier}.');
      } else {
        tz.setLocalLocation(tz.getLocation('Etc/UTC'));
      }
    } catch (error) {
      tz.setLocalLocation(tz.getLocation('Etc/UTC'));
      debugPrint(
        'No se pudo obtener la zona horaria local. Se utilizará UTC. Error: $error',
      );
    }
    _zonaHorariaInicializada = true;
  }

  @pragma('vm:entry-point')
  static void _manejarRespuestaBackground(NotificationResponse response) {
    debugPrint(
      'Respuesta de notificación recibida en background: ${response.payload}',
    );
  }
}

