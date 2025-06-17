import 'package:go_router/go_router.dart';
import 'package:river_app/presentation/screens/home_screen/home_screen.dart';
import 'package:river_app/presentation/screens/pokemon_screen/pokemon_screen.dart';
import 'package:river_app/presentation/screens/state_provider_screen/state_provider_screen.dart';
import 'package:river_app/presentation/screens/stream_provider_screen/stream_provider_screen.dart';
import 'package:river_app/presentation/screens/todos_screen/todos_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/state-provider',
      builder: (context, state) => const StateProviderScreen(),
    ),
    GoRoute(
      path: '/future-provider',
      builder: (context, state) => const PokemonScreen(),
    ),
    GoRoute(
      path: '/stream-provider',
      builder: (context, state) => const StreamProviderScreen(),
    ),
    GoRoute(
      path: '/todos-screen',
      builder: (context, state) => const TodosScreen(),
    ),
  ],
);
