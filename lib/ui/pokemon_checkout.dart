import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

import 'package:pokemon_black_market/provider/checkout_notifier.dart';
import 'package:pokemon_black_market/ui/pokemon_verify_checkout.dart';


class PokemonCheckout extends StatelessWidget {
  final formGlobalKey = GlobalKey <FormState> ();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CheckoutNotifier(),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Checkout'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formGlobalKey,
              child: Column(
                children: [
                  Text('Fill with your information'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Ash Salsa de Tomate',
                          labelText: 'Name'
                      ),
                      validator: (name) {
                        if (name == "") return "Invalid name";
                        context.read<CheckoutNotifier>().setName(name!);
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    child: TextFormField(
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Pueblo Paleta',
                          labelText: 'Address'
                      ),
                      validator: (address) {
                        if (address == "") return "Invalid address";
                        context.read<CheckoutNotifier>().setAddress(address!);
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: '1234567890',
                          labelText: 'Phone'
                      ),
                      validator: (phone) {
                        if (phone == "" || phone!.length != 10) return "Invalid phone";
                        context.read<CheckoutNotifier>().setPhone(phone);
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'la_salsa_de_ash@hotmail.com',
                          labelText: 'Email'
                      ),
                      validator: (email) {
                        if (!EmailValidator.validate(email!)) return "Invalid email";
                        context.read<CheckoutNotifier>().setEmail(email);
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: '0000 1111 2222 3333',
                          labelText: 'Card'
                      ),
                      validator: (cardNumber) {
                        if (!(cardNumber!.length == 16 || cardNumber.length == 15)) return "Invalid card";
                        context.read<CheckoutNotifier>().setCard(cardNumber);
                        return null;
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 16)),
                      onPressed: () {
                        if (formGlobalKey.currentState!.validate()) {
                          print(formGlobalKey.currentState!.validate());
                          formGlobalKey.currentState!.save();
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PokemonVerifyCheckout())
                          );
                        }
                      },
                      child: const Text('Continue'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
