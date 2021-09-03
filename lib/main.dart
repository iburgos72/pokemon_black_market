import 'package:flutter/material.dart';

import 'models/Pokemon.dart';

void main() => runApp(PokemonStore());

class PokemonStore extends StatefulWidget {
  const PokemonStore({Key? key}) : super(key: key);

  @override
  _PokemonStoreState createState() => _PokemonStoreState();
}

class _PokemonStoreState extends State<PokemonStore> {
  late Future<ListPokemon> futureListPokemon;

  @override //?? double override
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
      home: Scaffold(
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
                    return Card(
                      child: Text(snapshot.data!.results[index].name),
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
      ),
    );
  }
}
