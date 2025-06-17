import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_app/presentation/providers/provider.dart';

class PokemonScreen extends ConsumerWidget {
  const PokemonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonId = ref.watch(pokemonIdProvider);
    final pokemonAsync = ref.watch(pokemonProvider(pokemonId));

    return Scaffold(
      appBar: AppBar(title: Text('Pokemon id: $pokemonId')),
      body: Center(
        child: pokemonAsync.when(
          data: (value) => Text(value),
          error: (error, stackTrace) => Text('Error: $error'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: '+1',
            onPressed: () {
              ref.read(pokemonIdProvider.notifier).update((state) => state + 1);
            },
            child: const Icon(Icons.plus_one),
          ),
          const SizedBox(height: 10.0),
          FloatingActionButton(
            heroTag: '-1',
            onPressed: () {
              ref.read(pokemonIdProvider.notifier).update((state) => state - 1);
            },
            child: const Icon(Icons.exposure_minus_1_outlined),
          ),
        ],
      ),
    );
  }
}
