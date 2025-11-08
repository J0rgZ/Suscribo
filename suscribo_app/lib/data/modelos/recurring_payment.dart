import 'package:isar/isar.dart';

part 'recurring_payment.g.dart';

/// Representa un pago recurrente almacenado localmente en Isar.
@collection
class PagoRecurrente {
  PagoRecurrente({
    required this.nombre,
    required this.monto,
    required this.proximaFechaPago,
    this.diasNotificacion = 3,
    required this.tipoPago,
    required this.cicloPago,
  });

  /// Identificador único autogenerado por Isar.
  Id id = Isar.autoIncrement;

  /// Nombre descriptivo del pago, por ejemplo: "Netflix" o "Recibo de Luz".
  String nombre;

  /// Monto asociado al pago. Puede ser cero si el valor es variable.
  double monto;

  /// Fecha estimada del próximo cobro o vencimiento.
  DateTime proximaFechaPago;

  /// Días de antelación para enviar notificaciones al usuario.
  int diasNotificacion;

  /// Clasificación del pago según su naturaleza.
  @Enumerated(EnumType.name)
  TipoPago tipoPago;

  /// Frecuencia con la que se repite el pago.
  @Enumerated(EnumType.name)
  CicloPago cicloPago;
}

/// Tipos de pago soportados por la aplicación.
// ignore: constant_identifier_names
enum TipoPago { SUSCRIPCION, SERVICIO }

/// Ciclos de pago disponibles para organizar los cobros.
// ignore: constant_identifier_names
enum CicloPago { SEMANAL, MENSUAL, TRIMESTRAL, ANUAL }

