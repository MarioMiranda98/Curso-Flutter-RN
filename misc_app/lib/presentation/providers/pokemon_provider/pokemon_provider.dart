import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misc_app/data/data.dart';
import 'package:misc_app/domain/domain.dart';

final pokemonProvider = FutureProviderFamily<Pokemon, String>((ref, id) async {
  final pokemonRepository = ref.watch(pokemonRepositoryProvider);

  final (pokemon, message) = await pokemonRepository.getPokemon(id);

  if (pokemon != null) {
    return pokemon;
  }

  throw Exception(message);
});

final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonRepositoryImpl(datasource: PokemonDatasourceImpl());
});
