import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokemon_black_market/provider/select_view.dart';

class BottomNavBar extends StatelessWidget {
  final Map states = {
    "": 0,
    "cart": 1,
    "wishlist": 2,
  };

  @override
  Widget build(BuildContext context) {
    final _selectedIndex = states[Provider.of<SelectView>(context, listen: false).view];
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: 'Pokemons'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'Wishlist'
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.red,
      onTap: (i) => _onItemTapped(context, i),
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    List<String> views = <String>["", "cart", "wishlist"];
    Provider.of<SelectView>(context, listen: false).updateView(views[index]);
  }
}
