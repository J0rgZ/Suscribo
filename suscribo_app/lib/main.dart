import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app_router.dart';
import 'app/tema/tema_suscribo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: SuscriboApp()));
}

/// Punto de entrada principal que configura temas, localizaciones y rutas.
class SuscriboApp extends ConsumerWidget {
  const SuscriboApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    );
  }
}
