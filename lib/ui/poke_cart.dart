import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pokemon_black_market/models/pokemon.dart';
import 'package:pokemon_black_market/provider/poke_lists.dart';
import 'package:provider/provider.dart';

import 'components/bottom_nav_bar.dart';

class PokeCart extends StatelessWidget {
  PokeCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PokeList provider = Provider.of<PokeList>(context, listen: true);
    Map<String, Map<String, dynamic>> cart = provider.cart;

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
                Pokemon details = cart[key]!['details'];
                double price = details.weight! / details.height! * cart[key]!['total'];
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.network(details.sprites!.front_default!),
                          Column(
                              children: [
                                Text(key),
                                Text('Cantidad'),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => provider.decreasePokemonOnCart(key),
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
                                      onPressed: () => provider.increasePokemonOnCart(key),
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
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text('\$${double.parse(price.toStringAsFixed(2))}'),
                      )
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
                    '\$${double.parse(provider.totalPokemon.toStringAsFixed(2))}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 16)),
              onPressed: () {},
              child: const Text('go to checkout'),
            ),
          ),
        ],
      ),
    );
  }
}