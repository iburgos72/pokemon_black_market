import 'package:flutter/material.dart';
import 'package:pokemon_black_market/provider/cart_wishlist_notifier.dart';
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
            icon: IconBottomBar(
                counter: context.select<CartWishlistNotifier, int>((cart) => cart.totalItemsCart),
                icon: Icons.shopping_cart_outlined
            ),
            label: 'Shopping Cart'
        ),
        BottomNavigationBarItem(
            icon: IconBottomBar(
                counter: context.select<CartWishlistNotifier, int>((wishlist) => wishlist.totalItemsWishlist),
                icon: Icons.star_border
            ),
            label: 'Wishlist'
        ),
      ],
      currentIndex: context.watch<ViewNotifier>().selectedIndex,
      selectedItemColor: Colors.red,
      onTap: context.read<ViewNotifier>().setSelectedIndex,
    );
  }
}

class IconBottomBar extends StatelessWidget {
  final int counter;
  final IconData icon;

  const IconBottomBar({
    required this.counter,
    required this.icon,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (counter == 0) {
      return Icon(icon);
    }

    return Stack(
      children: <Widget>[
        Icon(icon),
        Positioned(
          right: 0,
          child: new Container(
            padding: EdgeInsets.all(1),
            decoration: new BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: BoxConstraints(
              minWidth: 12,
              minHeight: 12,
            ),
            child: new Text(
              '${counter.toString()}',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
