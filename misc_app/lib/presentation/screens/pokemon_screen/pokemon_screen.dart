import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misc_app/config/config.dart';
import 'package:misc_app/domain/domain.dart';
import 'package:misc_app/presentation/providers/providers.dart';

class PokemonScreen extends ConsumerWidget {
  const PokemonScreen({super.key, required this.pokemonId});

  final String pokemonId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonAsync = ref.watch(pokemonProvider(pokemonId));

    return pokemonAsync.when(
      data: (pokemon) => _PokemonView(pokemonEntity: pokemon),
      error: (e, stackTrace) => _Error(message: e.toString()),
      loading: () => _LoadingWidget(),
    );
  }
}

class _PokemonView extends StatelessWidget {
  const _PokemonView({required this.pokemonEntity});

  final Pokemon pokemonEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemonEntity.name),
        actions: [
          IconButton(
            onPressed: () {
              final String link = "";
              SharePlugin.shareLink(link, 'Mira este pókemon');
            },
            icon: const Icon(Icons.share_outlined),
          ),
        ],
      ),
      body: Center(
        child: Image.network(
          pokemonEntity.spriteFront,
          fit: BoxFit.contain,
          width: 150.0,
          height: 150.0,
        ),
      ),
    );
  }
}

class _Error extends StatelessWidget {
  const _Error({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(message)));
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
