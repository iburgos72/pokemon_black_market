import 'package:flutter/material.dart';
import 'package:pokemon_black_market/provider/select_view.dart';
import 'package:pokemon_black_market/ui/components/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

import '../models/pokemon.dart';

class ListPokemonView extends StatelessWidget {
  final Future<ListPokemon> futureListPokemon;

  ListPokemonView({
    Key? key,
    required this.futureListPokemon,
  }) : super (key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text('Pokemon')
      ),
      body: Center(
        child: FutureBuilder<ListPokemon>(
          future: futureListPokemon,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.results.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Provider.of<SelectView>(context, listen: false).updateView(snapshot.data!.results[index].name),
                    child: Card(
                      child: Text(snapshot.data!.results[index].name),
                    ),
                  );
                },
              );
              //return Text(snapshot.data!.results[0].name);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
