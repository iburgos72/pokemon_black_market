// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListPokemon _$ListPokemonFromJson(Map<String, dynamic> json) {
  return ListPokemon(
    next: json['next'] as String?,
    previous: json['previous'] as String?,
    results: (json['results'] as List<dynamic>)
        .map((e) => Pokemon.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ListPokemonToJson(ListPokemon instance) =>
    <String, dynamic>{
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };

Pokemon _$PokemonFromJson(Map<String, dynamic> json) {
  return Pokemon(
    id: json['id'] as int?,
    name: json['name'] as String,
    height: json['height'] as int?,
    sprites: json['sprites'] == null
        ? null
        : Sprites.fromJson(json['sprites'] as Map<String, dynamic>),
    types: (json['types'] as List<dynamic>?)
        ?.map((e) => Types.fromJson(e as Map<String, dynamic>))
        .toList(),
    weight: json['weight'] as int?,
  );
}

Map<String, dynamic> _$PokemonToJson(Pokemon instance) => <String, dynamic>{
      'height': instance.height,
      'id': instance.id,
      'name': instance.name,
      'sprites': instance.sprites,
      'types': instance.types,
      'weight': instance.weight,
    };

Sprites _$SpritesFromJson(Map<String, dynamic> json) {
  return Sprites(
    front_default: json['front_default'] as String?,
  );
}

Map<String, dynamic> _$SpritesToJson(Sprites instance) => <String, dynamic>{
      'front_default': instance.front_default,
    };

Types _$TypesFromJson(Map<String, dynamic> json) {
  return Types(
    slot: json['slot'] as int?,
    type: json['type'] == null
        ? null
        : Type.fromJson(json['type'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TypesToJson(Types instance) => <String, dynamic>{
      'slot': instance.slot,
      'type': instance.type,
    };

Type _$TypeFromJson(Map<String, dynamic> json) {
  return Type(
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
      'name': instance.name,
    };
