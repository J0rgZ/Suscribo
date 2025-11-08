import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../data/modelos/recurring_payment.dart';
import '../../data/servicios/payment_service.dart';

/// Pantalla que permite crear o editar un pago recurrente.
class PantallaFormularioPago extends ConsumerStatefulWidget {
  const PantallaFormularioPago({
    super.key,
    this.pagoEditar,
  });

  final PagoRecurrente? pagoEditar;

  @override
  ConsumerState<PantallaFormularioPago> createState() =>
      _PantallaFormularioPagoState();
}

class _PantallaFormularioPagoState
    extends ConsumerState<PantallaFormularioPago> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreController;
  late final TextEditingController _montoController;
  late final TextEditingController _diasController;
  late DateTime _fechaSeleccionada;
  late TipoPago _tipoSeleccionado;
  late CicloPago _cicloSeleccionado;
  bool _guardando = false;

  bool get _esEdicion => widget.pagoEditar != null;

  @override
  void initState() {
    super.initState();
    final pago = widget.pagoEditar;
    _nombreController = TextEditingController(text: pago?.nombre ?? '');
    _montoController = TextEditingController(
      text: pago != null ? pago.monto.toStringAsFixed(2) : '',
    );
    _diasController = TextEditingController(
      text: (pago?.diasNotificacion ?? 3).toString(),
    );
    _fechaSeleccionada = pago?.proximaFechaPago ?? DateTime.now();
    _tipoSeleccionado = pago?.tipoPago ?? TipoPago.SUSCRIPCION;
    _cicloSeleccionado = pago?.cicloPago ?? CicloPago.MENSUAL;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _montoController.dispose();
    _diasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titulo = _esEdicion ? 'Editar pago' : 'Nuevo pago';
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Completa los detalles del pago recurrente.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del pago',
                    prefixIcon: Icon(Icons.text_snippet_outlined),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (valor) {
                    if (valor == null || valor.trim().isEmpty) {
                      return 'Ingresa un nombre descriptivo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _montoController,
                  decoration: const InputDecoration(
                    labelText: 'Monto',
                    prefixIcon: Icon(Icons.attach_money_rounded),
                    hintText: 'Ejemplo: 15.99',
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.next,
                  validator: (valor) {
                    if (valor == null || valor.trim().isEmpty) {
                      return 'Ingresa el monto estimado';
                    }
                    final numero = double.tryParse(
                      valor.replaceAll(',', '.'),
                    );
                    if (numero == null || numero < 0) {
                      return 'Ingresa un número válido mayor o igual a cero';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<TipoPago>(
                        value: _tipoSeleccionado,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'Tipo de pago',
                          prefixIcon: Icon(Icons.category_outlined),
                        ),
                        items: TipoPago.values
                            .map(
                              (tipo) => DropdownMenuItem(
                                value: tipo,
                                child: Text(_textoTipo(tipo)),
                              ),
                            )
                            .toList(),
                        onChanged: (valor) {
                          if (valor != null) {
                            setState(() => _tipoSeleccionado = valor);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<CicloPago>(
                        value: _cicloSeleccionado,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'Ciclo de pago',
                          prefixIcon: Icon(Icons.repeat_rounded),
                        ),
                        items: CicloPago.values
                            .map(
                              (ciclo) => DropdownMenuItem(
                                value: ciclo,
                                child: Text(_textoCiclo(ciclo)),
                              ),
                            )
                            .toList(),
                        onChanged: (valor) {
                          if (valor != null) {
                            setState(() => _cicloSeleccionado = valor);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _SelectorFecha(
                  fecha: _fechaSeleccionada,
                  onSeleccionar: _seleccionarFecha,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _diasController,
                  decoration: const InputDecoration(
                    labelText: 'Días de notificación',
                    prefixIcon: Icon(Icons.notifications_active_outlined),
                    helperText: 'Días de anticipación para recordar al usuario',
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(signed: false),
                  validator: (valor) {
                    if (valor == null || valor.trim().isEmpty) {
                      return 'Indica cuántos días antes notificar';
                    }
                    final numero = int.tryParse(valor);
                    if (numero == null || numero < 0 || numero > 30) {
                      return 'Ingresa un valor entre 0 y 30';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _guardando ? null : () => context.pop(),
                        icon: const Icon(Icons.close_rounded),
                        label: const Text('Cancelar'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _guardando ? null : _guardar,
                        icon: _guardando
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.save_alt_rounded),
                        label: Text(_guardando ? 'Guardando...' : 'Guardar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _seleccionarFecha() async {
    final nuevaFecha = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      helpText: 'Selecciona la próxima fecha de pago',
      locale: const Locale('es', 'ES'),
    );
    if (nuevaFecha != null) {
      setState(() => _fechaSeleccionada = nuevaFecha);
    }
  }

  Future<void> _guardar() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    FocusScope.of(context).unfocus();

    setState(() => _guardando = true);
    final servicioPagos = ref.read(servicioPagosProvider);
    final messenger = ScaffoldMessenger.of(context);

    final nombre = _nombreController.text.trim();
    final monto = double.parse(_montoController.text.replaceAll(',', '.'));
    final diasNotificacion = int.parse(_diasController.text);

    try {
      if (_esEdicion) {
        final pago = widget.pagoEditar!;
        pago.nombre = nombre;
        pago.monto = monto;
        pago.tipoPago = _tipoSeleccionado;
        pago.cicloPago = _cicloSeleccionado;
        pago.proximaFechaPago = _fechaSeleccionada;
        pago.diasNotificacion = diasNotificacion;
        await servicioPagos.actualizarPago(pago);
        if (!mounted) return;
        messenger.showSnackBar(
          SnackBar(content: Text('Pago "${pago.nombre}" actualizado.')),
        );
      } else {
        final nuevoPago = PagoRecurrente(
          nombre: nombre,
          monto: monto,
          proximaFechaPago: _fechaSeleccionada,
          diasNotificacion: diasNotificacion,
          tipoPago: _tipoSeleccionado,
          cicloPago: _cicloSeleccionado,
        );
        await servicioPagos.agregarPago(nuevoPago);
        if (!mounted) return;
        messenger.showSnackBar(
          SnackBar(content: Text('Pago "${nuevoPago.nombre}" creado.')),
        );
      }
      if (!mounted) return;
      context.pop();
    } catch (error) {
      messenger.showSnackBar(
        SnackBar(content: Text('No se pudo guardar el pago: $error')),
      );
    } finally {
      if (mounted) {
        setState(() => _guardando = false);
      }
    }
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

class _SelectorFecha extends StatelessWidget {
  const _SelectorFecha({
    required this.fecha,
    required this.onSeleccionar,
  });

  final DateTime fecha;
  final VoidCallback onSeleccionar;

  @override
  Widget build(BuildContext context) {
    final formato = DateFormat.yMMMMd('es');
    final esquema = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onSeleccionar,
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Próxima fecha de pago',
          prefixIcon: Icon(Icons.event_available_rounded),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                formato.format(fecha.toLocal()),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Icon(
              Icons.edit_calendar_rounded,
              color: esquema.primary,
            ),
          ],
        ),
      ),
    );
  }
}

