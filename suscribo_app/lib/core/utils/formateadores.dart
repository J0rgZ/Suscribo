import 'package:intl/intl.dart';

/// Utilidades de formato reutilizables en la aplicación.
class FormateadorMoneda {
  FormateadorMoneda._();

  static final NumberFormat _formatoSoles =
      NumberFormat.currency(locale: 'es_PE', symbol: 'S/ ');

  static String enSoles(double monto) => _formatoSoles.format(monto);
}

