import 'package:flutter/material.dart';

import 'package:pokemon_black_market/ui/list_pokemon.dart';
import 'package:pokemon_black_market/ui/pokemon_details.dart';

import 'models/pokemon.dart';

void main() => runApp(PokemonStore());

class PokemonStore extends StatefulWidget {
  const PokemonStore({Key? key}) : super(key: key);

  @override
  _PokemonStoreState createState() => _PokemonStoreState();
}

class _PokemonStoreState extends State<PokemonStore> {
  late Future<ListPokemon> futureListPokemon;
  String? _selectedPokemon;

  @override
  void initState() {
    super.initState();
    futureListPokemon = fetchListPokemon();
  }

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
              onTap: _handlePokemonTapped,
            ),
          ),
          if (_selectedPokemon != null) PokemonDetails(pokemon: _selectedPokemon),
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }

          setState(() {
            _selectedPokemon = null;
          });

          return true;
        },
      ),
    );
  }

  void _handlePokemonTapped(Pokemon pokemon) {
    setState(() {
      _selectedPokemon = pokemon.name;
    });
  }
}
