import 'package:flutter/material.dart';
import 'package:pokemon_black_market/models/pokemon.dart';
import 'package:pokemon_black_market/provider/cart_wishlist_notifier.dart';
import 'package:provider/provider.dart';

class PokemonVerifyCheckout extends StatelessWidget {
  const PokemonVerifyCheckout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartWishlistNotifier>().cart;

    return Scaffold(
      appBar: AppBar(
        title: Text('Verify your data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Items Items Items Items Items Items Items Items Items Items Items Items Items Items Items Items Items Items '),
            Card(
              child: Column(
                children: [
                  Text('Items Items Items Items Items Items Items Items Items Items Items Items Items Items Items Items Items Items '),
                  ListView.builder(
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
                                      Text('Cantidad: ${cart[key]!['total']}'),
                                    ]
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text('\$${double.parse(price.toStringAsFixed(2))}'),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Card(
              child: Row(
                children: [
                  Text('Payment info')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
