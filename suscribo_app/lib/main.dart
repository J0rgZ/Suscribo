import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app_router.dart';
import 'app/tema/tema_suscribo.dart';
import 'app/state/onboarding_state.dart';
import 'package:lottie/lottie.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: SuscriboApp()));
}

class SuscriboApp extends ConsumerStatefulWidget {
  const SuscriboApp({super.key});

  @override
  ConsumerState<SuscriboApp> createState() => _SuscriboAppState();
}

class _SuscriboAppState extends ConsumerState<SuscriboApp>
    with WidgetsBindingObserver {
  bool _mostrarSplash = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _mostrarSplashTemporal();
    }
  }

  Future<void> _mostrarSplashTemporal() async {
    if (!mounted) return;
    setState(() => _mostrarSplash = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _mostrarSplash = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cargaOnboarding = ref.watch(cargarOnboardingProvider);

    return cargaOnboarding.when(
      loading: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: TemaSuscribo.temaClaro,
        darkTheme: TemaSuscribo.temaOscuro,
        home: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  TemaSuscribo.temaClaro.colorScheme.primary.withOpacity(0.1),
                  TemaSuscribo.temaClaro.colorScheme.secondary.withOpacity(0.1),
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/logo/logo_fondo_sin_fondo.png',
                    height: 120,
                  ),
                  const SizedBox(height: 24),
                  Lottie.asset(
                    'assets/lottie/Loading animation blue.json',
                    width: 180,
                    repeat: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      error: (error, stack) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'No logramos preparar la aplicación.\n$error',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      data: (_) {
        final router = ref.watch(routerProvider);
        return MaterialApp.router(
          title: 'Suscribo',
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          theme: TemaSuscribo.temaClaro,
          darkTheme: TemaSuscribo.temaOscuro,
          themeMode: ThemeMode.system,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('es'),
            Locale('en'),
          ],
          builder: (context, child) {
            return Stack(
              children: [
                child ?? const SizedBox.shrink(),
                if (_mostrarSplash)
                  Container(
                    color: Theme.of(context)
                        .colorScheme
                        .surface
                        .withOpacity(0.96),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/logo/logo_fondo_sin_fondo.png',
                          height: 120,
                        ),
                        const SizedBox(height: 24),
                        Lottie.asset(
                          'assets/lottie/Loading animation blue.json',
                          width: 160,
                          repeat: true,
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
