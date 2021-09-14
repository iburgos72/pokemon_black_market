import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import 'package:pokemon_black_market/helpers/string_helpers.dart';
import 'package:pokemon_black_market/provider/cart_wishlist_notifier.dart';
import 'package:pokemon_black_market/provider/pokemon_details_notifier.dart';
import 'package:pokemon_black_market/provider/view_notifier.dart';

class PokemonDetails extends StatelessWidget {
  Widget _buildContent(BuildContext context) {
    final pokemonDetails = context.read<PokemonDetailsNotifier>();
    final state = context.select<PokemonDetailsNotifier, PokemonDetailsState>((screenState) => screenState.state);
    final pokeList = context.read<CartWishlistNotifier>();

    switch (state) {
      case PokemonDetailsState.loading:
        return const Center(child: CircularProgressIndicator());
      case PokemonDetailsState.error:
        return const Center(child: Text('Generic Error'));
      case PokemonDetailsState.populated:
        final pokemon = pokemonDetails.pokemon;
        return Scaffold(
          appBar: AppBar(
            title: Text(pokemon!.name.capitalize()),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(pokemon.sprites!.front_default!),
              const Text(
                'Types:',
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pokemon.types!.map((e) => new Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(e.type!.name!.capitalize()),
                  ))
                ).toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                'Price:',
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                '\$${pokemon.totalPrice}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: 'cart',
                  backgroundColor: Color.fromRGBO(250, 0, 0, 1),
                  onPressed: () {
                    pokeList.addPokemonToCart(pokemon);
                    showTopSnackBar(
                      context, CustomSnackBar.success(
                        message: "Pokemon added to your cart",
                        backgroundColor: Color.fromRGBO(250, 0, 0, 1),
                      ),
                    );
                  },
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
                FloatingActionButton(
                  heroTag: 'wishlist',
                  backgroundColor: Color.fromRGBO(200, 0, 0, 1),
                  onPressed: () {
                    pokeList.addPokemonToWishlist(pokemon);
                    showTopSnackBar(
                      context, CustomSnackBar.info(
                        message: "Pokemon added to your wishlist",
                        backgroundColor: Color.fromRGBO(200, 0, 0, 1),
                      ),
                    );
                  },
                  child: const Icon(Icons.star_border),
                )
              ],
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pokemonName = context.read<ViewNotifier>().selectedPokemon;
    return ChangeNotifierProvider(
      create: (_) => PokemonDetailsNotifier(pokemonName),
      child: Builder(
        builder: (context) => _buildContent(context),
      ),
    );
  }
}