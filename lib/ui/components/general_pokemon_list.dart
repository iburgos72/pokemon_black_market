import 'package:flutter/material.dart';

import 'package:pokemon_black_market/models/pokemon.dart';

Widget buildIncreaseDecreaseSection(Map<String, dynamic> content, String total, String pokemon) {
  if (content['type'] == "") {
    return Text(total);
  }

  var typeFunc = content[content['type']];
  return Row(
    children: [
      ElevatedButton(
        onPressed: () => typeFunc['decreaseFunc'](pokemon),
        child: Icon(Icons.exposure_minus_1, color: Colors.white, size: 15,),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(5, 5),
          shape: CircleBorder(),
          padding: EdgeInsets.all(3),
          primary: Colors.grey,
          onPrimary: Colors.blueGrey,
        ),
      ),
      Text(total),
      ElevatedButton(
        onPressed: () => typeFunc['increaseFunc'](pokemon),
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
  );
}

Widget buildDeleteMoveSection(Map<String, dynamic> content, String pokemon) {
  if (content['type'] == "") {
    return Row();
  }

  var typeFunc = content[content['type']];
  return Row(
    children: [
      ElevatedButton(
        onPressed: () => typeFunc['removeFunc'](pokemon),
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
        onPressed: () => typeFunc['moveFunc'](pokemon),
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
                  buildDeleteMoveSection(content, pokeName),
                ],
              ),
            ],
          ),
        )
    );
  });
  return list;
}