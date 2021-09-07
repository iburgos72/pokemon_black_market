import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_black_market/provider/poke_lists.dart';
import 'package:pokemon_black_market/provider/select_view.dart';
import 'package:pokemon_black_market/ui/components/bottom_nav_bar.dart';
import 'package:pokemon_black_market/ui/poke_cart.dart';
import 'package:pokemon_black_market/ui/poke_wishlist.dart';
import 'package:provider/provider.dart';

import 'package:pokemon_black_market/ui/list_pokemon.dart';
import 'package:pokemon_black_market/ui/pokemon_details.dart';

import 'models/pokemon.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectView()),
        ChangeNotifierProvider(create: (_) => PokeList()),
      ],
      child: PokemonStore(),
    ),
  );
}

class PokemonStore extends StatelessWidget {
  late Future<ListPokemon> futureListPokemon = fetchListPokemon();

  PokemonStore({
    Key? key
  }) : super (key: key);

  @override
  Widget build(BuildContext context) {
    Views view = context.watch<SelectView>().view;
    String pokemon = context.read<SelectView>().pokemon;
    String title = pokemon == "" ? view.toString() : pokemon;
    Widget content = ListPokemonView(futureListPokemon: futureListPokemon);

    switch (view) {
      case Views.pokemon:
        content = PokemonDetails(pokemonName: pokemon);
        break;
      case Views.cart:
        content = PokeCart();
        break;
      case Views.wishlist:
        content = PokeWishlist();
        break;
    }

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pokemon'),
        ),
        body: content,
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}

