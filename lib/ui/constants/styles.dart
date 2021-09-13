import 'package:flutter/material.dart';

ButtonStyle elevateButtonStyle(Color primary, onPrimary) {
  return ElevatedButton.styleFrom(
    minimumSize: Size(5, 5),
    shape: CircleBorder(),
    padding: EdgeInsets.all(3),
    primary: primary,
    onPrimary: onPrimary,
  );
}

const boldText = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);