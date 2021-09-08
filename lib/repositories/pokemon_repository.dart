import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokemon_black_market/models/pokemon.dart';

class PokemonRepository {
  Future<ListPokemon> fetchListPokemon() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=10&offset=0'));

    if (response.statusCode == 200) {
      return ListPokemon.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load list of pokemon');
  }

  Future<Pokemon> fetchPokemon(String pokemonName) async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/' + pokemonName));

    if (response.statusCode == 200) {
      return Pokemon.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load pokemon');
  }
}