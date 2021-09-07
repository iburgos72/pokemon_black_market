import 'package:flutter/material.dart';

import 'components/bottom_nav_bar.dart';

class PokeWishlist extends Page {
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (builder) {
        return PokeWishlistScreen();
      }
    );
  }
}

class PokeWishlistScreen extends StatelessWidget {
  const PokeWishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist')
      ),
      body: Center(
        child: Text('Wishlist'),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
