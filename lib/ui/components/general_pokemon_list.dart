import 'package:flutter/material.dart';

import 'package:pokemon_black_market/models/pokemon.dart';
import 'package:pokemon_black_market/ui/constants/styles.dart';

Widget buildIncreaseDecreaseSection(Map<String, dynamic> content, String total, String pokemon) {
  final type = content['type'];
  if (type == "") {
    return Text(total);
  }

  final typeFunc = content[type];
  return Row(
    children: [
      ElevatedButton(
        key: Key('decrease'),
        onPressed: () => typeFunc['decreaseFunc'](pokemon),
        child: Icon(Icons.exposure_minus_1, color: Colors.white, size: 15,),
        style: elevateButtonStyle(Colors.grey, Colors.blueGrey),
      ),
      Text(total),
      ElevatedButton(
        key: Key('increase'),
        onPressed: () => typeFunc['increaseFunc'](pokemon),
        child: Icon(Icons.plus_one, color: Colors.white, size: 15,),
        style: elevateButtonStyle(Colors.red, Colors.redAccent),
      ),
    ],
  );
}

Widget buildDeleteMoveSection(Map<String, dynamic> content, Pokemon pokemon) {
  final type = content['type'];
  if (type == "") {
    return Row();
  }

  final typeFunc = content[type];
  IconData icon = Icons.star_border;
  if (type == "wishlist") {
    icon = Icons.shopping_cart_outlined;
  }
  return Row(
    children: [
      ElevatedButton(
        key: Key('remove'),
        onPressed: () => typeFunc['removeFunc'](pokemon.name),
        child: Icon(Icons.delete, color: Colors.white, size: 15,),
        style: elevateButtonStyle(Colors.grey, Colors.blueGrey),
      ),
      ElevatedButton(
        key: Key('move'),
        onPressed: () => typeFunc['moveFunc'](pokemon),
        child: Icon(icon, color: Colors.white, size: 15,),
        style: elevateButtonStyle(Colors.red, Colors.redAccent),
      ),
    ],
  );
}

List<Widget> generalPokemonList(Map<String, Map<String, dynamic>> pokeList, Map<String, dynamic> content) {
  List<Widget> list = [];
  pokeList.keys.forEach((pokeName) {
    Pokemon pokemon = pokeList[pokeName]!['details'];
    list.add(
      Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.network(pokemon.sprites!.front_default!),
                Column(
                  children: [
                    Text(pokeName),
                    Text('Amount:'),
                    buildIncreaseDecreaseSection(content, '${pokeList[pokeName]!['total']}', pokeName),
                  ]
                ),
              ],
            ),
            Column(
              children: [
                Text('\$${content['pokemonTotalPrice'](pokeName)}'),
                buildDeleteMoveSection(content, pokemon),
              ],
            ),
          ],
        ),
      )
    );
  });
  return list;
}