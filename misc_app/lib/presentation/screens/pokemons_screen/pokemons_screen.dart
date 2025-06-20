import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:misc_app/presentation/providers/providers.dart';

class PokemonsScreen extends StatelessWidget {
  const PokemonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: PokemonsView());
  }
}

class PokemonsView extends ConsumerStatefulWidget {
  const PokemonsView({super.key});

  @override
  ConsumerState<PokemonsView> createState() => _PokemonsViewState();
}

class _PokemonsViewState extends ConsumerState<PokemonsView> {
  final scrollController = ScrollController();

  void infiniteScroll() {
    final currentPokemons = ref.read(pokemonIdsProvider);

    if (currentPokemons.length > 400) {
      scrollController.removeListener(infiniteScroll);
      return;
    }

    if ((scrollController.position.pixels + 200) >
        scrollController.position.maxScrollExtent) {
      ref
          .read(pokemonIdsProvider.notifier)
          .update(
            (state) => [
              ...state,
              ...List.generate(30, (index) => state.length + 1 + index),
            ],
          );
    }
  }

  @override
  void initState() {
    scrollController.addListener(infiniteScroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          title: const Text('Pokemons'),
          floating: true,
          backgroundColor: Colors.white.withValues(alpha: 0.8),
        ),
        _PokemonGrid(),
      ],
    );
  }
}

class _PokemonGrid extends ConsumerWidget {
  const _PokemonGrid();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonIds = ref.watch(pokemonIdsProvider);

    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 2.0,
      ),
      itemCount: pokemonIds.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => context.push('/pokemons/${index + 1}'),
          child: Image.network(
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png",
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}
