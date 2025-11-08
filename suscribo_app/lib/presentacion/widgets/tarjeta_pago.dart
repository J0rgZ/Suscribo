import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../data/modelos/recurring_payment.dart';
import '../../core/utils/formateadores.dart';

/// Tarjeta visual que muestra el detalle de un pago recurrente.
class TarjetaPago extends StatelessWidget {
  const TarjetaPago({
    super.key,
    required this.pago,
    required this.onTap,
    required this.onMarcarPagado,
    required this.onEliminar,
    this.estaProcesando = false,
  });

  final PagoRecurrente pago;
  final VoidCallback onTap;
  final VoidCallback onMarcarPagado;
  final VoidCallback onEliminar;
  final bool estaProcesando;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final diasRestantes =
        pago.proximaFechaPago.difference(DateTime.now()).inDays;
    final estaPorVencer = diasRestantes <= pago.diasNotificacion;
    final formatoFecha = DateFormat.yMMMMd('es');

    final colorFondo = estaPorVencer
        ? esquema.errorContainer.withOpacity(0.25)
        : esquema.surface;
    final colorBorde =
        estaPorVencer ? esquema.error : esquema.outlineVariant;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: colorFondo,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorBorde, width: estaPorVencer ? 1.5 : 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.payment,
                    color: esquema.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      pago.nombre,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  PopupMenuButton<_AccionPago>(
                    onSelected: (accion) {
                      switch (accion) {
                        case _AccionPago.editar:
                          onTap();
                          break;
                        case _AccionPago.eliminar:
                          onEliminar();
                          break;
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: _AccionPago.editar,
                        child: Text('Editar'),
                      ),
                      PopupMenuItem(
                        value: _AccionPago.eliminar,
                        child: Text('Eliminar'),
                      ),
                    ],
                  ),
                  if (estaPorVencer)
                    Icon(Icons.notifications_active,
                        color: esquema.error, size: 22),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  _EtiquetaTexto(
                    icono: Icons.calendar_today_rounded,
                    texto: formatoFecha.format(pago.proximaFechaPago.toLocal()),
                  ),
                  _EtiquetaTexto(
                    icono: Icons.access_time_filled_rounded,
                    texto: _textoCiclo(pago.cicloPago),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  Chip(
                    avatar: Icon(
                      Icons.category_rounded,
                      color: esquema.onSecondaryContainer,
                    ),
                    label: Text(_textoTipo(pago.tipoPago)),
                    backgroundColor: esquema.secondaryContainer,
                    labelStyle: TextStyle(color: esquema.onSecondaryContainer),
                  ),
                  Chip(
                    avatar: Icon(
                      Icons.attach_money_rounded,
                      color: esquema.onPrimaryContainer,
                    ),
                    label: Text(FormateadorMoneda.enSoles(pago.monto)),
                    backgroundColor: esquema.primaryContainer,
                    labelStyle: TextStyle(color: esquema.onPrimaryContainer),
                  ),
                  if (estaPorVencer)
                    Chip(
                      avatar: Icon(
                        Icons.warning_amber_rounded,
                        color: esquema.onTertiaryContainer,
                      ),
                      label: Text(
                        diasRestantes >= 0
                            ? 'Vence en $diasRestantes días'
                            : 'Vencido hace ${diasRestantes.abs()} días',
                      ),
                      backgroundColor: esquema.tertiaryContainer,
                      labelStyle:
                          TextStyle(color: esquema.onTertiaryContainer),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: estaProcesando ? null : onMarcarPagado,
                  icon: estaProcesando
                      ? SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: esquema.onPrimary,
                          ),
                        )
                      : const Icon(Icons.check_circle_outline_rounded),
                  label: Text(
                    estaProcesando ? 'Procesando...' : 'Marcar como pagado',
                  ),
                ),
              ),
            ],
          ),
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

enum _AccionPago { editar, eliminar }

class _EtiquetaTexto extends StatelessWidget {
  const _EtiquetaTexto({
    required this.icono,
    required this.texto,
  });

  final IconData icono;
  final String texto;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: esquema.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono, size: 18, color: esquema.onSurfaceVariant),
          const SizedBox(width: 6),
          Text(
            texto,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}

