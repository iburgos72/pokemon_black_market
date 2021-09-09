import 'package:flutter/foundation.dart';

import 'package:pokemon_black_market/models/pokemon.dart';
import 'package:pokemon_black_market/repositories/pokemon_repository.dart';

enum PokemonDetailsState {
  loading,
  error,
  populated,
}

class PokemonDetailsNotifier with ChangeNotifier, DiagnosticableTreeMixin {
  final pokemonRepository = PokemonRepository();
  Pokemon? _pokemon;
  PokemonDetailsState _state = PokemonDetailsState.loading;

  Pokemon? get pokemon => _pokemon;
  PokemonDetailsState get state => _state;

  PokemonDetailsNotifier(String pokemonName) {
    fetchDetailsPokemon(pokemonName);
  }
  
  Future<void> fetchDetailsPokemon(String pokemonName) async {
    _state = PokemonDetailsState.loading;
    notifyListeners();
    try {
      _pokemon = await pokemonRepository.fetchPokemon(pokemonName);
      _state = PokemonDetailsState.populated;
      notifyListeners();
    } catch (e) {
      print(e);
      _state = PokemonDetailsState.error;
      notifyListeners();
    }
  }
}