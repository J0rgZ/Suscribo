import 'package:flutter/material.dart';
import '../../core/utils/formateadores.dart';

/// Widget que muestra un resumen general del estado de los pagos.
class ResumenPagos extends StatelessWidget {
  const ResumenPagos({
    super.key,
    required this.totalPagos,
    required this.gastoMensual,
    required this.totalSuscripciones,
    required this.gastoSuscripciones,
    required this.totalServicios,
    required this.gastoServicios,
  });

  final int totalPagos;
  final double gastoMensual;
  final int totalSuscripciones;
  final double gastoSuscripciones;
  final int totalServicios;
  final double gastoServicios;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              esquema.primary.withOpacity(0.85),
              esquema.secondary.withOpacity(0.85),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: esquema.primary.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumen mensual',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: esquema.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _MetricaPrincipal(
                  titulo: 'Pagos activos',
                  valor: '$totalPagos',
                  icono: Icons.list_alt_rounded,
                  colorTexto: esquema.onPrimary,
                ),
                const SizedBox(width: 16),
                _MetricaPrincipal(
                  titulo: 'Gasto mensual',
                  valor: FormateadorMoneda.enSoles(gastoMensual),
                  icono: Icons.account_balance_wallet_rounded,
                  colorTexto: esquema.onPrimary,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: esquema.surface,
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _FilaDetalle(
                    titulo: 'Suscripciones',
                    cantidad: totalSuscripciones,
                    monto: FormateadorMoneda.enSoles(gastoSuscripciones),
                    icono: Icons.subscriptions_outlined,
                    color: esquema.primary,
                  ),
                  const Divider(height: 24),
                  _FilaDetalle(
                    titulo: 'Servicios',
                    cantidad: totalServicios,
                    monto: FormateadorMoneda.enSoles(gastoServicios),
                    icono: Icons.miscellaneous_services_outlined,
                    color: esquema.secondary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricaPrincipal extends StatelessWidget {
  const _MetricaPrincipal({
    required this.titulo,
    required this.valor,
    required this.icono,
    required this.colorTexto,
  });

  final String titulo;
  final String valor;
  final IconData icono;
  final Color colorTexto;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icono, color: colorTexto),
            const SizedBox(width: 8),
            Text(
              titulo,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorTexto.withOpacity(0.85),
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          valor,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: colorTexto,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}

class _FilaDetalle extends StatelessWidget {
  const _FilaDetalle({
    required this.titulo,
    required this.cantidad,
    required this.monto,
    required this.icono,
    required this.color,
  });

  final String titulo;
  final int cantidad;
  final String monto;
  final IconData icono;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final texto = Theme.of(context).textTheme;
    return Row(
      children: [
        Icon(icono, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: texto.labelLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                '$cantidad pagos',
                style: texto.bodyMedium?.copyWith(
                  color: texto.bodyMedium?.color?.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
        Text(
          monto,
          style: texto.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

