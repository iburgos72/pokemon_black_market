import 'package:flutter/material.dart';
import 'package:pokemon_black_market/provider/list_pokemon_state.dart';
import 'package:pokemon_black_market/provider/select_view.dart';
import 'package:provider/provider.dart';

import '../models/pokemon.dart';

class ListPokemonView extends StatelessWidget {
  Widget _buildContent(BuildContext context) {
    final screenState = context.read<ListPokemonNotifier>();
    final state = context.select<ListPokemonNotifier, ListPokemonState>((screenState) => screenState.state);
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ListPokemonNotifier(),
      child: Builder(
        builder: (context) => _buildContent(context),
      ),
    );
  }

  void _onTap(BuildContext context, String pokemon) {
    SelectView provider = Provider.of<SelectView>(context, listen: false);
  }
}
