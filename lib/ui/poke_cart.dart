import 'package:flutter/material.dart';
import 'package:pokemon_black_market/ui/components/general_pokemon_list.dart';
import 'package:provider/provider.dart';

import 'package:pokemon_black_market/models/pokemon.dart';
import 'package:pokemon_black_market/provider/cart_wishlist_notifier.dart';
import 'package:pokemon_black_market/ui/pokemon_checkout.dart';

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
      Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('Pokemon', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
      ...generalPokemonList(cart, content).toList(),
      Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                  '\$${double.parse(cartWishlist.totalCart.toStringAsFixed(2))}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
      Container(
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 16)),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PokemonCheckout())
            );
          },
          child: const Text('go to checkout'),
        ),
      ),
    ];

    return ListView.builder(
      itemCount: itemsToDisplay.length,
      itemBuilder: (_, index) => itemsToDisplay[index]
    );
  }
}