import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokemon_black_market/helpers/string_helpers.dart';
import 'package:pokemon_black_market/provider/list_pokemon_notifier.dart';
import 'package:pokemon_black_market/provider/view_notifier.dart';
import 'package:pokemon_black_market/ui/pokemon_details.dart';

class ListPokemonView extends StatelessWidget {
  Widget _buildContent(BuildContext context) {
    final ListPokemonNotifier screenState = context.read<ListPokemonNotifier>();
    final ListPokemonState state = context.select<ListPokemonNotifier, ListPokemonState>((screenState) => screenState.state);

    switch (state) {
      case ListPokemonState.loading:
        return const Center(child: CircularProgressIndicator());
      case ListPokemonState.error:
        return const Center(child: Text('Generic Error'));
      case ListPokemonState.populated:
        final pokemonList = screenState.listPokemon;
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          itemCount: pokemonList.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => _onTap(context, pokemonList[index].name),
                  child: Text(pokemonList[index].name.capitalize())
                ),
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
