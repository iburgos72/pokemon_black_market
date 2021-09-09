import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokemon_black_market/models/pokemon.dart';
import 'package:pokemon_black_market/provider/cart_wishlist_notifier.dart';


class PokeWishlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartWishlist = context.read<CartWishlistNotifier>();
    final wishlist = context.watch<CartWishlistNotifier>().wishlist;

    if (wishlist.keys.length == 0) {
      return Center(
        child: Text('Add pokemons to your Wishlist'),
      );
    }

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                String key = wishlist.keys.elementAt(index);
                Pokemon pokemon = wishlist[key]!['details'];
                double price = pokemon.weight! / pokemon.height! * wishlist[key]!['total'];
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
                                      onPressed: () => cartWishlist.decreasePokemonOnWishlist(key),
                                      child: Icon(Icons.exposure_minus_1, color: Colors.white, size: 15,),
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(5, 5),
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(3),
                                        primary: Colors.grey,
                                        onPrimary: Colors.blueGrey,
                                      ),
                                    ),
                                    Text('${wishlist[key]!['total']}'),
                                    ElevatedButton(
                                      onPressed: () => cartWishlist.increasePokemonOnWishlist(key),
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
                                onPressed: () => cartWishlist.removePokemonFromWishlist(key),
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
                                onPressed: () => cartWishlist.moveFromWishlistToCart(pokemon),
                                child: Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 15,),
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
        ],
      ),
    );
  }
}
