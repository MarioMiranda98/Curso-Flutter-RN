import 'package:misc_app/domain/domain.dart';
import 'package:misc_app/data/datasources/isar_local_db_datasource_impl.dart';

class LocalDbRepositoryImpl extends LocalDbRepository {
  final LocalDbDatasource _datasource;

  LocalDbRepositoryImpl([LocalDbDatasource? datasource])
    : _datasource = datasource ?? IsarLocalDbDatasource();

  @override
  Future<void> insertPokemon(Pokemon pokemon) {
    return _datasource.insertPokemon(pokemon);
  }

  @override
  Future<List<Pokemon>> loadPokemons() {
    return _datasource.loadPokemons();
  }

  @override
  Future<int> pokemonCount() {
    return _datasource.pokemonCount();
  }
}
