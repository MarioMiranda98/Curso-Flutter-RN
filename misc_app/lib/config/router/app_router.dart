import 'package:go_router/go_router.dart';
import 'package:misc_app/presentation/screens/screens.dart';

class AppRouter {
  AppRouter._();

  static GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/permissions',
        builder: (context, state) => const PermissionScreen(),
      ),
      GoRoute(
        path: '/gyroscope',
        builder: (context, state) => const GyroscopeScreen(),
      ),

      GoRoute(
        path: '/accelerometer',
        builder: (context, state) => const AccelerometerScreen(),
      ),

      GoRoute(
        path: '/magnetometer',
        builder: (context, state) => const MagnetometerScreen(),
      ),

      GoRoute(
        path: '/gyroscope-ball',
        builder: (context, state) => const GyroscopeBallScreen(),
      ),

      GoRoute(
        path: '/compass',
        builder: (context, state) => const CompassScreen(),
      ),
      GoRoute(
        path: '/pokemons',
        builder: (context, state) => const PokemonsScreen(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '1';
              return PokemonScreen(pokemonId: id);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/biometrics',
        builder: (context, state) => const BiometricScreen(),
      ),
      GoRoute(
        path: '/controlled-map',
        builder: (context, state) => const ControlledMapScreen(),
      ),
      GoRoute(path: '/maps', builder: (context, state) => const MapScreen()),
      GoRoute(
        path: '/user-location',
        builder: (context, state) => const UserLocationScreen(),
      ),
      GoRoute(path: '/badge', builder: (context, state) => const BadgeScreen()),
    ],
  );
}
