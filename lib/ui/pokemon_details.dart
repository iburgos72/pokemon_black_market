import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/pokemon.dart';

class PokemonDetails extends Page {
  final String? pokemon;

  PokemonDetails({
    required this.pokemon,
  }): super(key: ValueKey(pokemon));

  Route createRoute(BuildContext) {
    print(pokemon);
    return MaterialPageRoute(
      settings: this,
      builder: (builder) {
        return PokemonDetailsScreen(pokemonName: pokemon);
      }
    );
  }
}

class PokemonDetailsScreen extends StatefulWidget {
  final String? pokemonName;

  const PokemonDetailsScreen({
    Key? key,
    this.pokemonName,
  }) : super(key: key);

  @override
  _PokemonDetailsScreenState createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  late Future<Pokemon> pokemon;

  @override
  void initState() {
    super.initState();
    pokemon = fetchPokemon(widget.pokemonName!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemonName!.toUpperCase()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<Pokemon>(
          future: pokemon,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              var data = snapshot.data!;
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(data.sprites!.frontDefault),
                    Text('Types:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: data.types!.map((e) => new Text(e.type!.name)).toList(),
                    ),
                    Text('Price:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('${(data.weight! / data.height!).toString()}'),
                  ],
                ),
              );
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