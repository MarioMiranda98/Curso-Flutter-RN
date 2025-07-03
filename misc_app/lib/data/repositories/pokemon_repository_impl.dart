import 'package:misc_app/domain/domain.dart';

class PokemonRepositoryImpl extends PokemonRepository {
  PokemonRepositoryImpl({required this.datasource});

  final PokemonDatasource datasource;

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    return await datasource.getPokemon(id);
  }
}
