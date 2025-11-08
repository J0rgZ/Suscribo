import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

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
      backgroundColor: Theme.of(context).colorScheme.surface,
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
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.05),
                Theme.of(context).colorScheme.secondary.withOpacity(0.05),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: asyncPagos.when(
            data: (pagos) => _ContenidoPagos(pagos: pagos, ref: ref),
            error: (error, stackTrace) => _buildError(context, error),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
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
  const _ContenidoPagos({required this.pagos, required this.ref});

  final List<PagoRecurrente> pagos;
  final WidgetRef ref;

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

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(pagosStreamProvider);
        await Future<void>.delayed(const Duration(milliseconds: 300));
      },
      edgeOffset: 12,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
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
          if (pagosOrdenados.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: _EstadoVacio(),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 100),
              sliver: SliverList.builder(
                itemCount: pagosOrdenados.length,
                itemBuilder: (context, index) {
                  final pago = pagosOrdenados[index];
                  final enProceso = estaProcesando.contains(pago.id);
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
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
              ),
            ),
        ],
      ),
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
    final resultado = await _mostrarFormularioPagoRealizado(context, pago);
    if (resultado == null) return;

    double? montoPagado = resultado.montoVariable;

    final procesando = ref.read(_pagosEnProcesoProvider.notifier);
    procesando.update((state) => {...state, pago.id});

    final servicioPagos = ref.read(servicioPagosProvider);
    final messenger = ScaffoldMessenger.of(context);

    try {
      String? rutaComprobante;
      if (resultado.comprobante != null) {
        final appDir = await getApplicationDocumentsDirectory();
        final comprobantesDir =
            Directory(path.join(appDir.path, 'comprobantes'));
        if (!await comprobantesDir.exists()) {
          await comprobantesDir.create(recursive: true);
        }
        final extension = path.extension(resultado.comprobante!.path);
        final nombreArchivo =
            'comprobante_${pago.id}_${DateTime.now().millisecondsSinceEpoch}$extension';
        final destino = path.join(comprobantesDir.path, nombreArchivo);
        await resultado.comprobante!.saveTo(destino);
        rutaComprobante = destino;
      }

      await servicioPagos.marcarComoPagado(
        pago,
        montoPagado: montoPagado,
        numeroOperacion: resultado.numeroOperacion?.trim().isEmpty ?? true
            ? null
            : resultado.numeroOperacion!.trim(),
        metodoPago: resultado.metodoPago?.trim().isEmpty ?? true
            ? null
            : resultado.metodoPago!.trim(),
        rutaComprobante: rutaComprobante,
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

  Future<_ResultadoPagoRealizado?> _mostrarFormularioPagoRealizado(
    BuildContext context,
    PagoRecurrente pago,
  ) {
    return showModalBottomSheet<_ResultadoPagoRealizado>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return _FormularioPagoRealizado(pago: pago);
      },
    );
  }
}

class _ResultadoPagoRealizado {
  _ResultadoPagoRealizado({
    this.montoVariable,
    this.numeroOperacion,
    this.metodoPago,
    this.comprobante,
  });

  final double? montoVariable;
  final String? numeroOperacion;
  final String? metodoPago;
  final XFile? comprobante;
}

class _FormularioPagoRealizado extends StatefulWidget {
  const _FormularioPagoRealizado({required this.pago});

  final PagoRecurrente pago;

  @override
  State<_FormularioPagoRealizado> createState() =>
      _FormularioPagoRealizadoState();
}

class _FormularioPagoRealizadoState extends State<_FormularioPagoRealizado> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _montoController;
  final TextEditingController _numeroOperacionController =
      TextEditingController();
  final TextEditingController _metodoPagoController = TextEditingController();
  XFile? _comprobante;
  bool _mostrandoOpciones = false;

  @override
  void initState() {
    super.initState();
    _montoController = TextEditingController();
  }

  @override
  void dispose() {
    _montoController.dispose();
    _numeroOperacionController.dispose();
    _metodoPagoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final necesitaMonto = widget.pago.monto == 0.0;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(
        bottom: bottomInset,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Confirmar pago realizado',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Completa la información opcional para mantener un registro más confiable.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              if (necesitaMonto)
                TextFormField(
                  controller: _montoController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Monto pagado',
                    prefixIcon: Icon(Icons.attach_money_rounded),
                  ),
                  validator: (valor) {
                    if (!necesitaMonto) return null;
                    if (valor == null || valor.trim().isEmpty) {
                      return 'Ingresa el monto pagado';
                    }
                    final numero = double.tryParse(valor.replaceAll(',', '.'));
                    if (numero == null || numero <= 0) {
                      return 'Ingresa un monto válido';
                    }
                    return null;
                  },
                ),
              if (necesitaMonto) const SizedBox(height: 16),
              TextFormField(
                controller: _numeroOperacionController,
                decoration: const InputDecoration(
                  labelText: 'Número de operación (opcional)',
                  prefixIcon: Icon(Icons.numbers_rounded),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _metodoPagoController,
                decoration: const InputDecoration(
                  labelText: 'Método de pago (opcional)',
                  hintText: 'Transferencia, tarjeta, efectivo...',
                  prefixIcon: Icon(Icons.account_balance_wallet_rounded),
                ),
              ),
              const SizedBox(height: 16),
              _ComprobanteSelector(
                comprobante: _comprobante,
                estaMostrandoOpciones: _mostrandoOpciones,
                onSeleccionar: _seleccionarComprobante,
                onEliminar: () => setState(() => _comprobante = null),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _guardar,
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('Confirmar'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _guardar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    double? monto;
    if (widget.pago.monto == 0.0) {
      monto = double.parse(_montoController.text.replaceAll(',', '.'));
    }

    Navigator.of(context).pop(
      _ResultadoPagoRealizado(
        montoVariable: monto,
        numeroOperacion: _numeroOperacionController.text.trim().isEmpty
            ? null
            : _numeroOperacionController.text,
        metodoPago: _metodoPagoController.text.trim().isEmpty
            ? null
            : _metodoPagoController.text,
        comprobante: _comprobante,
      ),
    );
  }

  Future<void> _seleccionarComprobante() async {
    setState(() => _mostrandoOpciones = true);
    final picker = ImagePicker();
    final fuente = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded),
              title: const Text('Tomar foto'),
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_rounded),
              title: const Text('Seleccionar de la galería'),
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    setState(() => _mostrandoOpciones = false);

    if (fuente == null) return;

    final archivo = await picker.pickImage(source: fuente, imageQuality: 85);
    if (archivo != null) {
      setState(() {
        _comprobante = archivo;
      });
    }
  }
}

class _ComprobanteSelector extends StatelessWidget {
  const _ComprobanteSelector({
    required this.comprobante,
    required this.onSeleccionar,
    required this.onEliminar,
    required this.estaMostrandoOpciones,
  });

  final XFile? comprobante;
  final VoidCallback onSeleccionar;
  final VoidCallback onEliminar;
  final bool estaMostrandoOpciones;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: esquema.surfaceVariant.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comprobante (opcional)',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: estaMostrandoOpciones ? null : onSeleccionar,
                icon: const Icon(Icons.cloud_upload_rounded),
                label: Text(
                  comprobante == null ? 'Adjuntar imagen' : 'Cambiar imagen',
                ),
              ),
              const SizedBox(width: 12),
              if (comprobante != null)
                OutlinedButton(
                  onPressed: onEliminar,
                  child: const Text('Quitar'),
                ),
            ],
          ),
          if (comprobante != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(comprobante!.path),
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ],
      ),
    );
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

