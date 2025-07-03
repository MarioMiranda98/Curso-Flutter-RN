import 'package:misc_app/domain/domain.dart';

abstract class PokemonRepository {
  Future<(Pokemon?, String)> getPokemon(String id);
}
