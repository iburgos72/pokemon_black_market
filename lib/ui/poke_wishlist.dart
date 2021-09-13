import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokemon_black_market/ui/components/general_list_header.dart';
import 'package:pokemon_black_market/ui/components/general_pokemon_list.dart';

import 'package:pokemon_black_market/provider/cart_wishlist_notifier.dart';

class PokeWishlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<CartWishlistNotifier>().wishlist;

    if (wishlist.keys.length == 0) {
      return const Center(
        child: Text('Add pokemons to your Wishlist'),
      );
    }

    final cartWishlist = context.read<CartWishlistNotifier>();
    final Map<String, dynamic> content = {
      "type": "wishlist",
      "pokemonTotalPrice": cartWishlist.getTotalPokemonWishlist,
      "wishlist": <String, dynamic> {
        "decreaseFunc": cartWishlist.decreasePokemonOnWishlist,
        "increaseFunc": cartWishlist.increasePokemonOnWishlist,
        "removeFunc": cartWishlist.removePokemonFromWishlist,
        "moveFunc": cartWishlist.moveFromWishlistToCart,
      },
    };

    final List<Widget> itemsToDisplay = [
      GeneralListHeader(),
      ...generalPokemonList(wishlist, content).toList(),
    ];

    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: itemsToDisplay.length,
        itemBuilder: (_, index) => itemsToDisplay[index]
    );
  }
}
