import 'package:flutter/material.dart';
import 'package:pokemon_black_market/provider/list_pokemon_notifier.dart';
import 'package:pokemon_black_market/provider/view_notifier.dart';
import 'package:pokemon_black_market/ui/pokemon_details.dart';
import 'package:provider/provider.dart';

import '../models/pokemon.dart';

class ListPokemonView extends StatelessWidget {
  Widget _buildContent(BuildContext context) {
    final ListPokemonNotifier screenState = context.read<ListPokemonNotifier>();
    final ListPokemonState state = context.select<ListPokemonNotifier, ListPokemonState>((screenState) => screenState.state);

    switch (state) {
      case ListPokemonState.loading:
        return Center(child: CircularProgressIndicator());
      case ListPokemonState.error:
        return Center(child: Text('Generic Error'));
      case ListPokemonState.populated:
        final pokemonList = screenState.listPokemon;
        return ListView.builder(
          itemCount: pokemonList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _onTap(context, pokemonList[index].name),
              child: Card(
                child: Text(pokemonList[index].name),
              ),
            );
          },
        );
    }
  }

  void _onTap(BuildContext context, String pokemon) {
    context.read<ViewNotifier>().setPokemon(pokemon);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PokemonDetails())
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ListPokemonNotifier(),
      child: Builder(
        builder: (context) => _buildContent(context),
      ),
    );
  }
}
