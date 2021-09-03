import 'dart:convert';

import 'package:http/http.dart' as http;

Future<ListPokemon> fetchListPokemon() async {
  final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=10&offset=0'));

  if (response.statusCode == 200) {
    return ListPokemon.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load pokemon');
  }
}

class ListPokemon {
  final String next;
  final String previous;
  final List<Pokemon> results;

  ListPokemon({
    required this.next,
    required this.previous,
    required this.results,
  });

  factory ListPokemon.fromJson(Map<String, dynamic> json) {
    late List<Pokemon> res;
    if (json['results'] != null) {
      res = <Pokemon>[];
      json['results'].forEach((v) {
        res.add(new Pokemon.fromJson(v));
      });
    }
    return ListPokemon(
      next: json['next'].toString(),
      previous: json['previous'].toString(),
      results: res,
    );
  }
}

class Pokemon {
  final int id;
  final String name;
  final int height;

  Pokemon({
    required this.id,
    required this.name,
    required this.height,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] as int? ?? 0, //??
      name: json['name'].toString(),
      height: json['height'] as int? ?? 0,
    );
  }
}