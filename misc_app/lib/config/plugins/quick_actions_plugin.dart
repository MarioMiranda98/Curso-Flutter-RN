import 'package:misc_app/config/router/app_router.dart';
import 'package:quick_actions/quick_actions.dart';

class QuickActionsPlugin {
  QuickActionsPlugin._();

  static void registerActions() {
    final QuickActions quickActions = QuickActions();
    quickActions.initialize((shortcutType) {
      switch (shortcutType) {
        case 'biometric':
          AppRouter.router.push('/biometrics');
          break;
        case 'compass':
          AppRouter.router.push('/compass');
          break;
        case 'pokemons':
          AppRouter.router.push('/pokemons');
          break;
        case 'charmander':
          AppRouter.router.push('/pokemons/4');
          break;
      }
    });

    quickActions.setShortcutItems([
      const ShortcutItem(
        type: 'biometric',
        localizedTitle: 'Biometricos',
        icon: 'finger',
      ),
      const ShortcutItem(
        type: 'compass',
        localizedTitle: 'Compass',
        icon: 'compass',
      ),
      const ShortcutItem(
        type: 'pokemons',
        localizedTitle: 'Pokemons',
        icon: 'pokemons',
      ),
      const ShortcutItem(
        type: 'charmander',
        localizedTitle: 'Charmander',
        icon: 'charmander',
      ),
    ]);
  }
}
