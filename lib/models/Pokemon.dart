import 'dart:convert';

import 'package:http/http.dart' as http;

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
  int? height;
  int? id;
  String? name;
  Sprites? sprites;
  List<Types>? types;
  int? weight;

  Pokemon({
    required this.id,
    required this.name,
    required this.height,
    required this.sprites,
    required this.types,
    required this.weight,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List<Types>? types_;
    if (json['types'] != null) {
      types_ = <Types>[];
      json['types'].forEach((v) {
        types_!.add(new Types.fromJson(v));
      });
    }

    Sprites? sprites_;
    if (json['sprites'] != null) {
      sprites_ = new Sprites.fromJson(json['sprites']);
    }

    return Pokemon(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      types: types_,
      sprites: sprites_,
    );
  }
}

class Sprites {
  String frontDefault;

  Sprites({
    required this.frontDefault,
  });

  factory Sprites.fromJson(Map<String, dynamic> json) {
    return Sprites(
      frontDefault: json['front_default']
    );
  }
}

class Types {
  int slot;
  Type? type;

  Types({
    required this.slot,
    required this.type,
  });

  factory Types.fromJson(Map<String, dynamic> json) {
    return Types(
        slot: json['slot'],
        type: json['type'] != null ? new Type.fromJson(json['type']) : null,
    );
  }
}

class Type {
  String name;

  Type({
    required this.name
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
        name: json['name']
    );
  }
}