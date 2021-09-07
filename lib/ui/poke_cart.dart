import 'package:flutter/material.dart';

import 'components/bottom_nav_bar.dart';

class PokeCart extends Page {
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (builder) {
        return PokeCartScreen();
      }
    );
  }
}

class PokeCartScreen extends StatelessWidget {
  const PokeCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Cart')
      ),
      body: Center(
        child: Text('Cart'),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

