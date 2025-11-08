import 'package:intl/intl.dart';

/// Utilidades de formato reutilizables en la aplicación.
class FormateadorMoneda {
  FormateadorMoneda._();

  static final NumberFormat _formatoNumero =
      NumberFormat.currency(locale: 'es_PE', symbol: '', decimalDigits: 2);

  static String enSoles(double monto) {
    final numero = _formatoNumero.format(monto).trim();
    return 'S/ $numero';
  }
}

