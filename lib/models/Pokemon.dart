import 'package:json_annotation/json_annotation.dart';

part 'pokemon.g.dart';

@JsonSerializable()
class ListPokemon {
  final String? next;
  final String? previous;
  final List<Pokemon> results;

  ListPokemon({
    required this.next,
    required this.previous,
    required this.results,
  });

  factory ListPokemon.fromJson(Map<String, dynamic> json) => _$ListPokemonFromJson(json);
  Map<String, dynamic> toJson() => _$ListPokemonToJson(this);
}

@JsonSerializable()
class Pokemon {
  int? height;
  int? id;
  String name;
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

  factory Pokemon.fromJson(Map<String, dynamic> json) => _$PokemonFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}

@JsonSerializable()
class Sprites {
  String? front_default;

  Sprites({
    required this.front_default,
  });

  factory Sprites.fromJson(Map<String, dynamic> json) => _$SpritesFromJson(json);
  Map<String, dynamic> toJson() => _$SpritesToJson(this);
}

@JsonSerializable()
class Types {
  int? slot;
  Type? type;

  Types({
    required this.slot,
    required this.type,
  });

  factory Types.fromJson(Map<String, dynamic> json) => _$TypesFromJson(json);
  Map<String, dynamic> toJson() => _$TypesToJson(this);
}

@JsonSerializable()
class Type {
  String? name;

  Type({
    required this.name
  });

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);
  Map<String, dynamic> toJson() => _$TypeToJson(this);
}