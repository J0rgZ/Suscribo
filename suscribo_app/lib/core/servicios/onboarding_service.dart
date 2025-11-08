import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  static const _claveOnboarding = 'onboarding_completado';

  Future<bool> cargarEstado() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_claveOnboarding) ?? false;
  }

  Future<void> marcarCompletado() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_claveOnboarding, true);
  }

  Future<void> reiniciar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_claveOnboarding);
  }
}

