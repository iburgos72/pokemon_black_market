import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokemon_black_market/ui/components/general_list_header.dart';
import 'package:pokemon_black_market/ui/components/general_pokemon_list.dart';
import 'package:pokemon_black_market/ui/constants/styles.dart';
import 'package:pokemon_black_market/ui/pokemon_checkout.dart';

import 'package:pokemon_black_market/provider/cart_wishlist_notifier.dart';

class PokeCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartWishlistNotifier>().cart;

    if (cart.keys.length == 0) {
      return Center(
        child: Text('Add pokemons to your cart'),
      );
    }

    final cartWishlist = context.read<CartWishlistNotifier>();
    final Map<String, dynamic> content = {
      "type": "cart",
      "pokemonTotalPrice": cartWishlist.getTotalPokemon,
      "cart": <String, dynamic> {
        "decreaseFunc": cartWishlist.decreasePokemonOnCart,
        "increaseFunc": cartWishlist.increasePokemonOnCart,
        "removeFunc": cartWishlist.removePokemonFromCart,
        "moveFunc": cartWishlist.moveFromCartToWishlist,
      },
    };

    final List<Widget> itemsToDisplay = [
      GeneralListHeader(),
      ...generalPokemonList(cart, content).toList(),
      Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total', style: boldText),
              Text('\$${double.parse(cartWishlist.totalCart.toStringAsFixed(2))}', style: boldText),
            ],
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 16)),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PokemonCheckout())
            );
          },
          child: const Text('Checkout'),
        ),
      ),
    ];

    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: itemsToDisplay.length,
        itemBuilder: (_, index) => itemsToDisplay[index]
    );
  }
}