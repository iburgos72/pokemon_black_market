import 'package:flutter/foundation.dart';

enum Views {
  home,
  cart,
  wishlist,
}

class ViewNotifier with ChangeNotifier, DiagnosticableTreeMixin {
  int _selectedIndex = 0;
  String _selectedPokemon = "";

  int get selectedIndex => _selectedIndex;
  String get selectedPokemon => _selectedPokemon;
  Views get view => Views.values[_selectedIndex];

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void setPokemon(String pokemon) {
    _selectedPokemon = pokemon;
    notifyListeners();
  }

  void debugFillProprties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty('view', view));
    properties.add(StringProperty('pokemonView', selectedPokemon));
    properties.add(IntProperty('selectedIndex', selectedIndex));
  }
}