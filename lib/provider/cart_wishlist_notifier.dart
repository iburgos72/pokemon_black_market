import 'package:flutter/foundation.dart';

import 'package:pokemon_black_market/models/pokemon.dart';

class CartWishlistNotifier with ChangeNotifier, DiagnosticableTreeMixin {
  Map<String, Map<String, dynamic>> _cart = {};
  Map<String, Map<String, dynamic>> _wishlist = {};

  Map<String, Map<String, dynamic>> get cart => _cart;
  Map<String, Map<String, dynamic>> get wishlist => _wishlist;

  double get totalCart => _calculateTotalCart();
  double calculateTotalPokemonCart(String pokemon) => cart[pokemon]!['details'].price * _cart[pokemon]!['total'];
  String getTotalPokemonCart(String pokemon) => double.parse(calculateTotalPokemonCart(pokemon).toStringAsFixed(2)).toString();
  double _calculateTotalCart() {
    double total = 0;
    _cart.keys.forEach((pokemon) {
      total = total + calculateTotalPokemonCart(pokemon);
    });
    return total;
  }

  double calculateTotalPokemonWishlist(String pokemon) => wishlist[pokemon]!['details'].price * _wishlist[pokemon]!['total'];
  String getTotalPokemonWishlist(String pokemon) => double.parse(calculateTotalPokemonWishlist(pokemon).toStringAsFixed(2)).toString();

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

  void removePokemonFromCart(String pokemon) {
    _cart.remove(pokemon);
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

  void moveFromCartToWishlist(Pokemon pokemon) {
    final String p = pokemon.name;
    if (_wishlist[p] == null) {
      _wishlist[p] = {
        "total": _cart[p]!['total'],
        "details": pokemon
      };
      _cart.remove(p);
    } else {
      _wishlist[p]!['total'] = _wishlist[p]!['total'] + _cart[p]!['total'];
      _cart.remove(p);
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

  void removePokemonFromWishlist(String pokemon) {
    _wishlist.remove(pokemon);
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

  void moveFromWishlistToCart(Pokemon pokemon) {
    final String p = pokemon.name;
    if (_cart[p] == null) {
      _cart[p] = {
        "total": _wishlist[p]!['total'],
        "details": pokemon
      };
      _wishlist.remove(p);
    } else {
      _cart[p]!['total'] = _cart[p]!['total'] + _wishlist[p]!['total'];
      _wishlist.remove(p);
    }
    notifyListeners();
  }
}