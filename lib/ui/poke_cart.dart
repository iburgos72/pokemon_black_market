import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokemon_black_market/models/pokemon.dart';
import 'package:pokemon_black_market/provider/cart_wishlist_notifier.dart';
import 'package:pokemon_black_market/ui/pokemon_checkout.dart';

class PokeCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartWishlist = context.read<CartWishlistNotifier>();
    final cart = context.watch<CartWishlistNotifier>().cart;

    if (cart.keys.length == 0) {
      return Center(
        child: Text('Add pokemons to your cart'),
      );
    }

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
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
          Container(
            child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
              itemCount: cart.length,
              itemBuilder: (context, index) {
                String key = cart.keys.elementAt(index);
                Pokemon pokemon = cart[key]!['details'];
                double price = pokemon.weight! / pokemon.height! * cart[key]!['total'];
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.network(pokemon.sprites!.front_default!),
                          Column(
                              children: [
                                Text(key),
                                Text('Cantidad'),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => cartWishlist.decreasePokemonOnCart(key),
                                      child: Icon(Icons.exposure_minus_1, color: Colors.white, size: 15,),
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(5, 5),
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(3),
                                        primary: Colors.grey,
                                        onPrimary: Colors.blueGrey,
                                      ),
                                    ),
                                    Text('${cart[key]!['total']}'),
                                    ElevatedButton(
                                      onPressed: () => cartWishlist.increasePokemonOnCart(key),
                                      child: Icon(Icons.plus_one, color: Colors.white, size: 15,),
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(5, 5),
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(3),
                                        primary: Colors.red,
                                        onPrimary: Colors.redAccent,
                                      ),
                                    ),
                                  ],
                                )
                              ]
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('\$${double.parse(price.toStringAsFixed(2))}'),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () => cartWishlist.removePokemonFromCart(key),
                                child: Icon(Icons.delete, color: Colors.white, size: 15,),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(5, 5),
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(3),
                                  primary: Colors.grey,
                                  onPrimary: Colors.blueGrey,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => cartWishlist.moveFromCartToWishlist(pokemon),
                                child: Icon(Icons.star_border, color: Colors.white, size: 15,),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(5, 5),
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(3),
                                  primary: Colors.red,
                                  onPrimary: Colors.redAccent,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
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
                    '\$${double.parse(cartWishlist.totalPokemon.toStringAsFixed(2))}',
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
        ],
      ),
    );
  }
}