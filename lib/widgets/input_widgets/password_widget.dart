import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordWidget extends StatefulWidget {
  final String name;
  final String innerText;
  final TextEditingController controller;

  PasswordWidget({
    required this.name,
    required this.innerText,
    required this.controller,
  });

  @override
  _PasswordWidgetState createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool _isObscure = true;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 805, // <--- Questo fa sì che prenda tutta la larghezza del genitore
      margin: const EdgeInsets.symmetric(vertical: 8.0), // margine verticale per respirare
      child: TextFormField(
        controller: widget.controller,
        obscureText: _isObscure,
        decoration: InputDecoration(
          labelText: widget.innerText,
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
        ),
      ),
    );
  }
}
