import 'package:flutter/material.dart';
import 'package:pokemon_black_market/provider/select_view.dart';
import 'package:provider/provider.dart';

import 'package:pokemon_black_market/ui/list_pokemon.dart';
import 'package:pokemon_black_market/ui/pokemon_details.dart';

import 'models/pokemon.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectView()),
      ],
      child: PokemonStore(),
    ),
  );
}

class PokemonStore extends StatelessWidget {
  late Future<ListPokemon> futureListPokemon = fetchListPokemon();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Navigator(
        pages: [
          MaterialPage(
            key: ValueKey('Home'),
            child: ListPokemonView(
              futureListPokemon: futureListPokemon,
            ),
          ),
          if (context.watch<SelectView>().view != "") PokemonDetails(),
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;
          context.read<SelectView>().updateView("");
          return true;
        },
      ),
    );
  }
}

