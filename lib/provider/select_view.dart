import 'package:flutter/foundation.dart';

enum Views {
  cart,
  checkout,
  home,
  pokemon,
  wishlist,
}

class SelectView with ChangeNotifier, DiagnosticableTreeMixin {
  Views _view = Views.home;
  String _pokemon = "";

  Views get view => _view;
  String get pokemon => _pokemon;

  void updateView(Views view) {
    _view = view;
    notifyListeners();
  }

  void updatePokemon(String pokemon) {
    _pokemon = pokemon;
    notifyListeners();
  }

  @override
  void debugFillProprties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty('view', view));
    properties.add(StringProperty('pokemon', pokemon));
  }
}