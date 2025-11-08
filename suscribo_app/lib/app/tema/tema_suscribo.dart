import 'package:flutter/material.dart';

/// Configuración centralizada del tema Material Design 3 de la aplicación.
class TemaSuscribo {
  TemaSuscribo._();

  /// Tema claro basado en una paleta suave de azules y grises.
  static final ThemeData temaClaro = _construirTema(
    brillo: Brightness.light,
    esquema: ColorScheme.fromSeed(
      seedColor: const Color(0xFF3A7BD5),
      brightness: Brightness.light,
      primary: const Color(0xFF3A7BD5),
    ),
  );

  /// Tema oscuro con contraste adecuado para lectura nocturna.
  static final ThemeData temaOscuro = _construirTema(
    brillo: Brightness.dark,
    esquema: ColorScheme.fromSeed(
      seedColor: const Color(0xFF4C5C68),
      brightness: Brightness.dark,
      primary: const Color(0xFF6FA8DC),
    ),
  );

  /// Construye un ThemeData consistente con Material Design 3.
  static ThemeData _construirTema({
    required Brightness brillo,
    required ColorScheme esquema,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: brillo,
      colorScheme: esquema,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: esquema.surface,
        foregroundColor: esquema.onSurface,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: esquema.primary,
        foregroundColor: esquema.onPrimary,
        shape: const StadiumBorder(),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      textTheme: _construirTipografia(esquema, brillo),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: esquema.primary,
        contentTextStyle: TextStyle(color: esquema.onPrimary),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static TextTheme _construirTipografia(ColorScheme esquema, Brightness brillo) {
    final tipografiaBase = brillo == Brightness.dark
        ? Typography.material2021(platform: TargetPlatform.android).white
        : Typography.material2021(platform: TargetPlatform.android).black;

    return tipografiaBase.apply(
      displayColor: esquema.onSurface,
      bodyColor: esquema.onSurface,
    );
  }
}

