import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app/rutas_app.dart';
import '../data/modelos/recurring_payment.dart';
import '../presentacion/pantallas/pantalla_formulario_pago.dart';
import '../presentacion/pantallas/pantalla_historial.dart';
import '../presentacion/pantallas/pantalla_principal.dart';

/// Proveedor que expone la configuración de navegación basada en GoRouter.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: false,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: RutasApp.principal,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: PantallaPrincipal(),
        ),
        routes: [
          GoRoute(
            path: 'pago',
            name: RutasApp.formularioPago,
            pageBuilder: (context, state) {
              final pago = state.extra as PagoRecurrente?;
              return CustomTransitionPage(
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: PantallaFormularioPago(pagoEditar: pago),
              );
            },
          ),
          GoRoute(
            path: 'historial',
            name: RutasApp.historialPagos,
            pageBuilder: (context, state) => CustomTransitionPage(
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: const PantallaHistorialPagos(),
            ),
          ),
        ],
      ),
    ],
  );
});

