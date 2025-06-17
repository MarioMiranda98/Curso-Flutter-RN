import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_app/config/helpers/pokemon_service.dart';

final pokemonIdProvider = StateProvider<int>((ref) {
  return 1;
});

final pokemonProvider = FutureProvider.family<String, int>((ref, id) async {
  final name = await PokemonService.getPokemonName(id);

  return name;
});
