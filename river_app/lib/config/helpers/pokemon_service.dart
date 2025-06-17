import 'package:dio/dio.dart';

class PokemonService {
  PokemonService._();

  static Future<String> getPokemonName(int pokemonId) async {
    final Dio dio = Dio();

    await Future.delayed(const Duration(seconds: 2));

    try {
      final response = await dio.get(
        'https://pokeapi.co/api/v2/pokemon/$pokemonId',
      );

      return response.data['name'] ?? 'Nombre no disponible';
    } catch (e) {
      throw Exception('Name not found');
    }
  }
}
