import 'package:dio/dio.dart';
import 'package:misc_app/data/mappers/pokemon_mapper.dart';
import 'package:misc_app/domain/domain.dart';

class PokemonDatasourceImpl extends PokemonDatasource {
  PokemonDatasourceImpl()
    : dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2'));

  final Dio dio;

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    try {
      final resp = await dio.get('/pokemon/$id');

      final Pokemon pokemonEntity = PokemonMapper.pokemonResponseModelToEntity(
        resp.data,
      );

      return (pokemonEntity, 'Data obtenida correctamente');
    } catch (e) {
      return (null, 'No se pudo obtener el pokemon: $e');
    }
  }
}
