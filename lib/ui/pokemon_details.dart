import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokemon_black_market/provider/select_view.dart';

import '../models/pokemon.dart';
import 'components/bottom_nav_bar.dart';

class PokemonDetails extends StatelessWidget {
  final String? pokemonName;
  late Future<Pokemon> pokemon = fetchPokemon(pokemonName!);

  PokemonDetails({
    Key? key,
    this.pokemonName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<Pokemon>(
        future: pokemon,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            var data = snapshot.data!;
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(data.sprites!.front_default!),
                  Text('Types:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: data.types!.map((e) => new Text(e.type!.name!)).toList(),
                  ),
                  Text('Price:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${(data.weight! / data.height!).toString()}'),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}