import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokemon_black_market/provider/cart_wishlist_notifier.dart';
import 'package:pokemon_black_market/provider/view_notifier.dart';
import 'package:pokemon_black_market/ui/components/bottom_nav_bar.dart';
import 'package:pokemon_black_market/ui/list_pokemon.dart';
import 'package:pokemon_black_market/ui/poke_cart.dart';
import 'package:pokemon_black_market/ui/poke_wishlist.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ViewNotifier()),
        ChangeNotifierProvider(create: (_) => CartWishlistNotifier()),
      ],
      child: PokemonStore(),
    ),
  );
}

class PokemonStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Views view = context.select<ViewNotifier, Views>((selectView) => selectView.view);
    //String pokemon = context.read<SelectView>().pokemon;
    String pokemon = 'charmander';
    String title = pokemon == "" ? view.toString() : pokemon;
    Widget content;

    switch (view) {
      case Views.home:
        content = ListPokemonView();
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

