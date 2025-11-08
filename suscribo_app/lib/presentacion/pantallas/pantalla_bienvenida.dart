import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../app/rutas_app.dart';
import 'package:suscribo_app/app/state/onboarding_state.dart';

class PantallaBienvenida extends ConsumerStatefulWidget {
  const PantallaBienvenida({super.key});

  @override
  ConsumerState<PantallaBienvenida> createState() =>
      _PantallaBienvenidaState();
}

class _PantallaBienvenidaState extends ConsumerState<PantallaBienvenida> {
  bool _aceptaTerminos = false;
  bool _procesando = false;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              tema.colorScheme.primary.withOpacity(0.15),
              tema.colorScheme.secondary.withOpacity(0.15),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.calendar_month_rounded,
                    size: 96,
                    color: tema.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Bienvenido a Suscribo',
                  style: tema.textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  'Tu asistente móvil para organizar suscripciones, servicios básicos y pagos fijos sin sorpresas.',
                  style: tema.textTheme.bodyLarge
                      ?.copyWith(color: tema.colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 32),
                _Caracteristica(
                  icono: Icons.notifications_active_rounded,
                  titulo: 'Recordatorios oportunos',
                  descripcion:
                      'Recibe alertas antes del vencimiento y recordatorios diarios si un pago sigue pendiente.',
                ),
                _Caracteristica(
                  icono: Icons.receipt_long_rounded,
                  titulo: 'Historial con comprobantes',
                  descripcion:
                      'Guarda montos, métodos y comprobantes fotográficos para validar cada pago.',
                ),
                _Caracteristica(
                  icono: Icons.assessment_rounded,
                  titulo: 'Visión clara de tus gastos',
                  descripcion:
                      'Visualiza el gasto mensual estimado y clasificado por suscripciones y servicios.',
                ),
                const SizedBox(height: 28),
                Text(
                  'Permisos necesarios',
                  style: tema.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _PermisoCard(
                  icono: Icons.notifications_none_rounded,
                  titulo: 'Notificaciones',
                  descripcion:
                      'Te avisamos de los vencimientos y te recordamos si un pago sigue pendiente.',
                ),
                _PermisoCard(
                  icono: Icons.camera_alt_rounded,
                  titulo: 'Cámara',
                  descripcion:
                      'Captura comprobantes de pago para mantener tu historial completo.',
                ),
                _PermisoCard(
                  icono: Icons.photo_library_rounded,
                  titulo: Platform.isIOS ? 'Fotos' : 'Galería',
                  descripcion:
                      'Adjunta imágenes existentes como respaldo de tus pagos realizados.',
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Checkbox(
                      value: _aceptaTerminos,
                      onChanged: (valor) {
                        setState(() {
                          _aceptaTerminos = valor ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Text('He leído y acepto los '),
                          GestureDetector(
                            onTap: _mostrarTerminos,
                            child: Text(
                              'términos y condiciones',
                              style: tema.textTheme.bodyMedium?.copyWith(
                                color: tema.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: !_aceptaTerminos || _procesando
                      ? null
                      : _completarBienvenida,
                  icon: _procesando
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.check_circle_rounded),
                  label: Text(
                    _procesando ? 'Preparando...' : 'Comenzar a usar Suscribo',
                  ),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _completarBienvenida() async {
    setState(() => _procesando = true);

    await _solicitarPermisos();

    await ref.read(onboardingServiceProvider).marcarCompletado();
    ref.read(onboardingEstadoProvider.notifier).state = true;

    if (mounted) {
      setState(() => _procesando = false);
      context.goNamed(RutasApp.principal);
    }
  }

  Future<void> _solicitarPermisos() async {
    final solicitudes = <Permission>[
      Permission.notification,
      Permission.camera,
      if (Platform.isIOS) Permission.photos else Permission.storage,
    ];

    for (final permiso in solicitudes) {
      if (await permiso.isDenied || await permiso.isRestricted) {
        await permiso.request();
      }
    }
  }

  void _mostrarTerminos() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.75,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          builder: (context, controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: ListView(
                controller: controller,
                children: const [
                  Text(
                    'Términos y condiciones',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '• Suscribo almacena tus pagos recurrentes en tu dispositivo y en la nube cuando actives la sincronización.\n\n'
                    '• Eres responsable de verificar los montos y fechas antes de ejecutar un pago real.\n\n'
                    '• Toda la información privada (montos, comprobantes, métodos de pago) se maneja con fines de organización personal; no realizamos cobros ni transferencias.\n\n'
                    '• Puedes revocar permisos de notificaciones o cámara desde la configuración del sistema, aunque algunas funciones podrían quedar limitadas.\n\n'
                    '• Al continuar confirmas que los datos que guardes son tuyos y que aceptas nuestras políticas de privacidad.',
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Si tienes dudas o comentarios, escríbenos a soporte@suscribo.app',
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}

class _Caracteristica extends StatelessWidget {
  const _Caracteristica({
    required this.icono,
    required this.titulo,
    required this.descripcion,
  });

  final IconData icono;
  final String titulo;
  final String descripcion;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: tema.colorScheme.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icono, color: tema.colorScheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: tema.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  descripcion,
                  style: tema.textTheme.bodyMedium?.copyWith(
                    color: tema.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PermisoCard extends StatelessWidget {
  const _PermisoCard({
    required this.icono,
    required this.titulo,
    required this.descripcion,
  });

  final IconData icono;
  final String titulo;
  final String descripcion;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tema.colorScheme.surface.withOpacity(0.92),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: tema.colorScheme.primary.withOpacity(0.12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: tema.colorScheme.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icono, color: tema.colorScheme.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: tema.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  descripcion,
                  style: tema.textTheme.bodySmall?.copyWith(
                    color: tema.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

