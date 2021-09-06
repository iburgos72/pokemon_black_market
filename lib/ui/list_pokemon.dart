import 'package:flutter/material.dart';

import '../models/pokemon.dart';

class ListPokemonView extends StatelessWidget {
  final Future<ListPokemon> futureListPokemon;
  final ValueChanged<Pokemon> onTap;

  ListPokemonView({
    required this.futureListPokemon,
    required this.onTap,
  });

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
                    onTap: () => onTap(snapshot.data!.results[index]),
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
    );
  }
}
