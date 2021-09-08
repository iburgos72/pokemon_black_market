import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_black_market/provider/poke_lists.dart';
import 'package:pokemon_black_market/repositories/pokemon_repository.dart';
import 'package:provider/provider.dart';

import 'package:pokemon_black_market/provider/select_view.dart';

import '../models/pokemon.dart';
import 'components/bottom_nav_bar.dart';

class PokemonDetails extends StatelessWidget {
  final String? pokemonName;
  late Future<Pokemon> pokemon = PokemonRepository().fetchPokemon(pokemonName!);

  PokemonDetails({
    Key? key,
    this.pokemonName,
  }) : super(key: key);

  void _addToCart(BuildContext context, Pokemon pokemon) {
    Provider.of<PokeList>(context, listen: false).addPokemonToCart(pokemon);
  }

  void _addToWishlist(BuildContext context, Pokemon pokemon) {
    Provider.of<PokeList>(context, listen: false).addPokemonToWishlist(pokemon);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<Pokemon>(
        future: pokemon,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            Pokemon data = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(data.sprites!.front_default!),
                Text('Types:', style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: data.types!.map((e) => new Text(e.type!.name!)).toList(),
                ),
                Text('Price:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${(data.weight! / data.height!).toString()}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () => _addToCart(context, data),
                      child: Icon(Icons.shopping_cart_outlined),
                    ),
                    FloatingActionButton(
                      onPressed: () => _addToWishlist(context, data),
                      child: Icon(Icons.star_border),
                    )
                  ],
                ),
              ],
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