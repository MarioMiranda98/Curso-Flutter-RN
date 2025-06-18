import 'package:misc_app/domain/domain.dart';

abstract class PokemonDatasource {
  Future<(PokemonEntity?, String)> getPokemon(String id);
}
