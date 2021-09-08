import 'package:flutter/foundation.dart';
import 'package:pokemon_black_market/models/pokemon.dart';
import 'package:pokemon_black_market/provider/select_view.dart';
import 'package:pokemon_black_market/repositories/pokemon_repository.dart';

enum ListPokemonState {
  loading,
  error,
  populated,
}

class ListPokemonNotifier with ChangeNotifier, DiagnosticableTreeMixin {
  final pokemonRepository = PokemonRepository();
  List<Pokemon> _listPokemon = [];
  ListPokemonState _state = ListPokemonState.loading;

  List<Pokemon> get listPokemon => _listPokemon;
  ListPokemonState get state => _state;

  ListPokemonNotifier() {
    fetchListPokemon();
  }

  Future<void> fetchListPokemon() async {
    _state = ListPokemonState.loading;
    notifyListeners();
    try {
      final listPokemonResp = await pokemonRepository.fetchListPokemon();
      _listPokemon = listPokemonResp.results;
      _state = ListPokemonState.populated;
      notifyListeners();
    } catch (e) {
      print(e);
      _state = ListPokemonState.error;
      notifyListeners();
    }
  }
}
