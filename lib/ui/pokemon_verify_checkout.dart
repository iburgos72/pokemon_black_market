import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PokemonVerifyCheckout extends StatelessWidget {
  const PokemonVerifyCheckout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify your data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: Row(
                children: [
                  Text('Items')
                ],
              ),
            ),
            Card(
              child: Row(
                children: [
                  Text('Payment info')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
