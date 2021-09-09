import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokemon_black_market/provider/view_notifier.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      currentIndex: context.read<ViewNotifier>().selectedIndex,
      selectedItemColor: Colors.red,
      onTap: context.read<ViewNotifier>().setSelectedIndex,
    );
  }
}