import 'package:flutter/material.dart';

import 'package:pokemon_black_market/ui/constants/styles.dart';

class GeneralListHeader extends StatelessWidget {
  const GeneralListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Pokemon', style: boldText),
            const Text('Price', style: boldText),
          ],
        ),
      ),
    );
  }
}
