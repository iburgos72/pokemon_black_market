import 'package:flutter/foundation.dart';
import 'package:pokemon_black_market/models/pokemon.dart';

class PokeList with ChangeNotifier, DiagnosticableTreeMixin {
  Map<String, Map<String, dynamic>> _cart = {};
  Map<String, Map<String, dynamic>> _wishlist = {};

  Map<String, Map<String, dynamic>> get cart => _cart;
  Map<String, Map<String, dynamic>> get wishlist => _wishlist;

  double get totalPokemon => calculateTotal();

  double calculateTotal() {
    double total = 0;
    _cart.keys.forEach((e) {
      Pokemon details = cart[e]!['details'];
      total = total + (details.weight! / details.height! * _cart[e]!['total']);
    });

    return total;
  }

  void addPokemonToCart(Pokemon pokemon) {
    if (_cart[pokemon.name] == null) {
      _cart[pokemon.name] = {
        "total": 1,
        "details": pokemon
      };
    } else {
      _cart[pokemon.name]!['total']++;
    }
    notifyListeners();
  }

  void removePokemonFromCart(Pokemon pokemon) {
    _cart.remove(pokemon.name);
    notifyListeners();
  }

  void increasePokemonOnCart(String pokemon) {
    _cart[pokemon]!['total']++;
    notifyListeners();
  }

  void decreasePokemonOnCart(String pokemon) {
    _cart[pokemon]!['total']--;
    if (_cart[pokemon]!['total'] == 0) {
      _cart.remove(pokemon);
    }
    notifyListeners();
  }

  void addPokemonToWishlist(Pokemon pokemon) {
    if (_wishlist[pokemon.name] == null) {
      _wishlist[pokemon.name] = {
        "total": 1,
        "details": pokemon
      };
    } else {
      _wishlist[pokemon.name]!['total']++;
    }
    notifyListeners();
  }

  void removePokemonFromWishlist(Pokemon pokemon) {
    _wishlist.remove(pokemon.name);
    notifyListeners();
  }

  void increasePokemonOnWishlist(String pokemon) {
    _wishlist[pokemon]!['total']++;
    notifyListeners();
  }

  void decreasePokemonOnWishlist(String pokemon) {
    _wishlist[pokemon]!['total']--;
    if (_wishlist[pokemon]!['total'] == 0) {
      _wishlist.remove(pokemon);
    }
    notifyListeners();
  }
}