import 'package:flutter/foundation.dart';

enum Views {
  home,
  cart,
  wishlist,
}

class SelectView with ChangeNotifier, DiagnosticableTreeMixin {
  int _selectedIndex = 0;
  Views _view = Views.home;

  int get selectedIndex => _selectedIndex;
  Views get view => Views.values[_selectedIndex];

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  @override
  void debugFillProprties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty('view', view));
  }
}