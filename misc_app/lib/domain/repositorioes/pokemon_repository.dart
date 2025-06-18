import 'package:misc_app/domain/domain.dart';

abstract class PokemonRepository {
  Future<(PokemonEntity?, String)> getPokemon(String id);
}
