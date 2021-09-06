import 'package:flutter/foundation.dart';

class SelectView with ChangeNotifier, DiagnosticableTreeMixin {
  String _view = "";

  String get view => _view;

  void updateView(String view) {
    _view = view;
    notifyListeners();
  }

  @override
  void debugFillProprties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('view', view));
  }
}