import 'package:misc_app/domain/domain.dart';

abstract class PokemonDatasource {
  Future<(Pokemon?, String)> getPokemon(String id);
}
