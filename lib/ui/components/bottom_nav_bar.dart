import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokemon_black_market/provider/select_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(BuildContext context, int index) {
    List<Views> views = <Views>[Views.home, Views.cart, Views.wishlist];

    SelectView provider = Provider.of<SelectView>(context, listen: false);
    provider.updateView(views[index]);
    provider.updatePokemon("");

    setState(() {
      _selectedIndex = index;
    });
  }

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
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.red,
      onTap: (i) => _onItemTapped(context, i),
    );
  }
}