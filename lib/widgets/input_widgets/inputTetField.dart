import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget{

  final String name;
  final String innerText;
  final Icon? icon;
  final TextEditingController controller;

  InputTextWidget(this.name, this.innerText, {super.key, this.icon, required this.controller});

  // Metodo astratto di validazione
  String? validateInput(String value) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: name,
          hintText: innerText,
          border: OutlineInputBorder(),
          suffixIcon: icon, // L'icona a destra
        ),
        validator: (value) {
          return validateInput(value!); // Esegui la validazione
        },
      ),
    );
  }
}