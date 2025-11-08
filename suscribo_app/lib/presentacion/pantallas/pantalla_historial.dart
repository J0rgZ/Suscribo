import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/utils/formateadores.dart';
import '../../data/modelos/historial_pago.dart';
import '../../data/modelos/recurring_payment.dart';
import '../../data/servicios/payment_service.dart';

class PantallaHistorialPagos extends ConsumerWidget {
  const PantallaHistorialPagos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historialAsync = ref.watch(historialPagosStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de pagos'),
      ),
      body: SafeArea(
        child: historialAsync.when(
          data: (registros) {
            if (registros.isEmpty) {
              return const _HistorialVacio();
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: registros.length,
              itemBuilder: (context, index) {
                final registro = registros[index];
                return _TarjetaHistorial(registro: registro);
              },
            );
          },
          error: (error, stackTrace) => _ErrorHistorial(error: error),
          loading: () =>
              const Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),
    );
  }
}

class _TarjetaHistorial extends StatelessWidget {
  const _TarjetaHistorial({required this.registro});

  final HistorialPago registro;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final fecha = DateFormat.yMMMMd('es')
        .add_Hm()
        .format(registro.fechaRegistro.toLocal());

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.receipt_long_rounded, color: esquema.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    registro.nombre,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Chip(
                  label: Text(_textoTipo(registro.tipoPago)),
                  backgroundColor: esquema.primaryContainer,
                  labelStyle: TextStyle(color: esquema.onPrimaryContainer),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today_outlined,
                    size: 18, color: esquema.onSurfaceVariant),
                const SizedBox(width: 8),
                Text(
                  fecha,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.sync_alt_outlined,
                    size: 18, color: esquema.onSurfaceVariant),
                const SizedBox(width: 8),
                Text(
                  _textoCiclo(registro.cicloPago),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Monto pagado: ${FormateadorMoneda.enSoles(registro.montoPagado)}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  static String _textoTipo(TipoPago tipo) {
    switch (tipo) {
      case TipoPago.SUSCRIPCION:
        return 'Suscripción';
      case TipoPago.SERVICIO:
        return 'Servicio';
    }
  }

  static String _textoCiclo(CicloPago ciclo) {
    switch (ciclo) {
      case CicloPago.SEMANAL:
        return 'Semanal';
      case CicloPago.MENSUAL:
        return 'Mensual';
      case CicloPago.TRIMESTRAL:
        return 'Trimestral';
      case CicloPago.ANUAL:
        return 'Anual';
    }
  }
}

class _HistorialVacio extends StatelessWidget {
  const _HistorialVacio();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history_toggle_off_rounded,
                size: 80, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              'Aún no registras pagos realizados.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Cada vez que marques un pago como realizado, aparecerá aquí para que puedas consultarlo cuando quieras.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorHistorial extends StatelessWidget {
  const _ErrorHistorial({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'No pudimos cargar el historial.\n$error',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

