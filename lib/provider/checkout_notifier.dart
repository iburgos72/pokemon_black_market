import 'package:flutter/foundation.dart';

class CheckoutNotifier with ChangeNotifier, DiagnosticableTreeMixin {
  String _name = "";
  String _address = "";
  String _phone = "";
  String _email = "";
  String _card = "";

  String get name => _name;
  String get address => _address;
  String get phone => _phone;
  String get email => _email;
  String get card => _card;

  void setName(String name) {
    _name = name;
  }

  void setAddress(String address) {
    _address = address;
  }

  void setPhone(String phone) {
    _phone = phone;
  }

  void setEmail(String email) {
    _email = email;
  }

  void setCard(String card) {
    _card = card;
  }
}