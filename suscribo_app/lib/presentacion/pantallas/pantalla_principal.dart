import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import '../../app/rutas_app.dart';
import '../../data/modelos/recurring_payment.dart';
import '../../data/servicios/payment_service.dart';
import '../widgets/resumen_pagos.dart';
import '../widgets/tarjeta_pago.dart';

/// Estado interno para controlar pagos actualmente en proceso.
final _pagosEnProcesoProvider = StateProvider<Set<Id>>(
  (ref) => <Id>{},
);

/// Dashboard principal que muestra resumen y detalle de pagos recurrentes.
class PantallaPrincipal extends ConsumerWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPagos = ref.watch(pagosStreamProvider);

    final Widget? fab;
    if (asyncPagos is AsyncData<List<PagoRecurrente>> &&
        asyncPagos.value.isEmpty) {
      fab = null;
    } else {
      fab = FloatingActionButton.extended(
        onPressed: () => context.pushNamed(RutasApp.formularioPago),
        icon: const Icon(Icons.add_circle_outline_rounded),
        label: const Text('Agregar pago'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Suscribo'),
            Text(
              'Controla tus pagos y suscripciones',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Historial de pagos',
            onPressed: () => context.pushNamed(RutasApp.historialPagos),
            icon: const Icon(Icons.history_rounded),
          ),
        ],
      ),
      floatingActionButton: fab,
      body: SafeArea(
        child: asyncPagos.when(
          data: (pagos) => _ContenidoPagos(pagos: pagos),
          error: (error, stackTrace) => _buildError(context, error),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, Object error) {
    final esquema = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning_amber_rounded, size: 48, color: esquema.error),
          const SizedBox(height: 16),
          Text(
            'Ocurrió un error al cargar tus pagos.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: esquema.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _ContenidoPagos extends ConsumerWidget {
  const _ContenidoPagos({required this.pagos});

  final List<PagoRecurrente> pagos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagosOrdenados = [...pagos]
      ..sort((a, b) => a.proximaFechaPago.compareTo(b.proximaFechaPago));
    final estimacionesMensuales = pagosOrdenados
        .map(_estimacionMensual)
        .fold<double>(0, (acc, valor) => acc + valor);
    final totalSuscripciones =
        pagosOrdenados.where((p) => p.tipoPago == TipoPago.SUSCRIPCION).length;
    final totalServicios =
        pagosOrdenados.where((p) => p.tipoPago == TipoPago.SERVICIO).length;
    final gastoSuscripciones = pagosOrdenados
        .where((p) => p.tipoPago == TipoPago.SUSCRIPCION)
        .map(_estimacionMensual)
        .fold<double>(0, (acc, valor) => acc + valor);
    final gastoServicios = pagosOrdenados
        .where((p) => p.tipoPago == TipoPago.SERVICIO)
        .map(_estimacionMensual)
        .fold<double>(0, (acc, valor) => acc + valor);
    final estaProcesando = ref.watch(_pagosEnProcesoProvider);

    if (pagosOrdenados.isEmpty) {
      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ResumenPagos(
              totalPagos: 0,
              gastoMensual: 0,
              totalSuscripciones: 0,
              gastoSuscripciones: 0,
              totalServicios: 0,
              gastoServicios: 0,
            ),
          ),
          const SliverFillRemaining(
            hasScrollBody: false,
            child: _EstadoVacio(),
          ),
        ],
      );
    }

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: ResumenPagos(
            totalPagos: pagosOrdenados.length,
            gastoMensual: estimacionesMensuales,
            totalSuscripciones: totalSuscripciones,
            gastoSuscripciones: gastoSuscripciones,
            totalServicios: totalServicios,
            gastoServicios: gastoServicios,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 100),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final pago = pagosOrdenados[index];
                final enProceso = estaProcesando.contains(pago.id);
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TarjetaPago(
                    pago: pago,
                    onTap: () => context.pushNamed(
                      RutasApp.formularioPago,
                      extra: pago,
                    ),
                    onMarcarPagado: () =>
                        _marcarComoPagado(context, ref, pago),
                    onEliminar: () => _eliminarPago(context, ref, pago),
                    estaProcesando: enProceso,
                  ),
                );
              },
              childCount: pagosOrdenados.length,
            ),
          ),
        ),
      ],
    );
  }

  double _estimacionMensual(PagoRecurrente pago) {
    switch (pago.cicloPago) {
      case CicloPago.SEMANAL:
        return pago.monto * 4.33;
      case CicloPago.MENSUAL:
        return pago.monto;
      case CicloPago.TRIMESTRAL:
        return pago.monto / 3;
      case CicloPago.ANUAL:
        return pago.monto / 12;
    }
  }

  Future<void> _marcarComoPagado(
    BuildContext context,
    WidgetRef ref,
    PagoRecurrente pago,
  ) async {
    double? montoPagado;

    if (pago.monto == 0.0) {
      montoPagado = await _solicitarMontoVariable(context);
      if (montoPagado == null) {
        return;
      }
    }

    final procesando = ref.read(_pagosEnProcesoProvider.notifier);
    procesando.update((state) => {...state, pago.id});

    final servicioPagos = ref.read(servicioPagosProvider);
    final messenger = ScaffoldMessenger.of(context);

    try {
      await servicioPagos.marcarComoPagado(
        pago,
        montoPagado: montoPagado,
      );
      if (!context.mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Pago "${pago.nombre}" marcado como realizado. '
            'Próximo vencimiento: '
            '${DateFormat.yMMMMd('es').format(pago.proximaFechaPago.toLocal())}.',
          ),
        ),
      );
    } catch (error) {
      messenger.showSnackBar(
        SnackBar(
          content: Text('No se pudo actualizar el pago: $error'),
        ),
      );
    } finally {
      procesando.update((state) {
        final nuevo = {...state};
        nuevo.remove(pago.id);
        return nuevo;
      });
    }
  }

  Future<double?> _solicitarMontoVariable(BuildContext context) async {
    final controlador = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final resultado = await showDialog<double>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Monto pagado'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: controlador,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Ingresa el monto pagado',
                prefixIcon: Icon(Icons.attach_money_rounded),
              ),
              validator: (valor) {
                if (valor == null || valor.trim().isEmpty) {
                  return 'Ingresa un monto válido';
                }
                final numero = double.tryParse(
                  valor.replaceAll(',', '.'),
                );
                if (numero == null || numero < 0) {
                  return 'Ingresa una cantidad numérica positiva';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  final numero = double.parse(
                    controlador.text.replaceAll(',', '.'),
                  );
                  Navigator.of(context).pop(numero);
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
    controlador.dispose();
    return resultado;
  }

  Future<void> _eliminarPago(
    BuildContext context,
    WidgetRef ref,
    PagoRecurrente pago,
  ) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar pago'),
        content: Text(
          '¿Deseas eliminar el pago "${pago.nombre}"? Se borrará su historial.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmar != true) return;

    final servicioPagos = ref.read(servicioPagosProvider);
    try {
      await servicioPagos.eliminarPago(pago.id);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pago "${pago.nombre}" eliminado.')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo eliminar el pago: $error')),
      );
    }
  }
}

class _EstadoVacio extends StatelessWidget {
  const _EstadoVacio();

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.savings_rounded, size: 72, color: esquema.primary),
            const SizedBox(height: 24),
            Text(
              'Aún no tienes pagos registrados',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Agrega tu primer pago recurrente para recibir recordatorios oportunos y mantener tus finanzas al día.',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: esquema.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => context.pushNamed(RutasApp.formularioPago),
              icon: const Icon(Icons.add_circle_outline_rounded),
              label: const Text('Agregar pago'),
            ),
          ],
        ),
      ),
    );
  }
}

