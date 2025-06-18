import 'package:misc_app/data/models/pokemon_response_model.dart';
import 'package:misc_app/domain/domain.dart';

class PokemonMapper {
  PokemonMapper._();

  static PokemonEntity pokemonResponseModelToEntity(Map<String, dynamic> json) {
    final pokemonModel = PokemonResponseModel.fromJson(json);

    return PokemonEntity(
      id: pokemonModel.id,
      name: pokemonModel.name,
      frontSprite: pokemonModel.sprites.frontDefault,
    );
  }
}
