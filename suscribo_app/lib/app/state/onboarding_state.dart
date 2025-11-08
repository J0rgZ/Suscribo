import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/servicios/onboarding_service.dart';

final onboardingServiceProvider =
    Provider<OnboardingService>((ref) => OnboardingService());

final onboardingEstadoProvider = StateProvider<bool?>((ref) => null);

final cargarOnboardingProvider = FutureProvider<void>((ref) async {
  final completado =
      await ref.read(onboardingServiceProvider).cargarEstado();
  ref.read(onboardingEstadoProvider.notifier).state = completado;
});

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this.ref) {
    _subscription = ref.listen<bool?>(
      onboardingEstadoProvider,
      (_, __) => notifyListeners(),
    );
  }

  final Ref ref;
  late final ProviderSubscription<bool?> _subscription;

  bool? get onboardingCompletado => ref.read(onboardingEstadoProvider);

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}

final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  final notifier = RouterNotifier(ref);
  ref.onDispose(notifier.dispose);
  return notifier;
});

