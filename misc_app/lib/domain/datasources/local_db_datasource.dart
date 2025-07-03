import 'package:misc_app/domain/domain.dart';

abstract class LocalDbDatasource {
  Future<List<Pokemon>> loadPokemons();

  Future<int> pokemonCount();

  Future<void> insertPokemon(Pokemon pokemon);
}
