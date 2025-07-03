import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misc_app/data/repositories/local_db_repository_impl.dart';
import 'package:misc_app/domain/domain.dart';

final pokemonDbProvider = FutureProvider.autoDispose<List<Pokemon>>((
  ref,
) async {
  final localDb = LocalDbRepositoryImpl();
  final pokemons = await localDb.loadPokemons();

  return pokemons;
});
