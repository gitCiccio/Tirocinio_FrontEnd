import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knock_collector_mobile_application/widgets/input_widgets/name_widget.dart';
import 'package:knock_collector_mobile_application/widgets/input_widgets/password_widget.dart';


import 'input_widgets/email_widget.dart';

class SignUp extends StatelessWidget{

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _checkPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final VoidCallback toggleRegistration;

  SignUp(this._formKey, {super.key, required this.toggleRegistration});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
          color: Colors.white,
          height: double.infinity,
          child: FractionallySizedBox(
              alignment: Alignment.center,
              widthFactor: 0.8,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(color: Colors.blue,
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Row(children: [
                      Text('Dati profilo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white))
                    ],),),
                    NameWidget('Nome', 'Inserisci il nome', controller: _nameController),
                    NameWidget('Cognome', 'Inserisci il cognome', controller: _surnameController),
                    EmailWidget(name: 'email', innerText: 'Inserisci la tua email', controller: _emailController, icon: Icon(Icons.email),),
                    Padding(padding: EdgeInsets.all(10)),
                    PasswordWidget(name: 'password', innerText: 'Inserisci la tua password', controller: _passwordController),
                    Padding(padding: EdgeInsets.all(10)),
                    PasswordWidget(name: 'conferma password', innerText: 'Conferma la tua password', controller: _checkPasswordController),
                    Padding(padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue
                            ),
                            onPressed: () {
                              // Validare il Form
                              if (_formKey.currentState!.validate()) {
                                if(_checkPasswordController.text != _passwordController.text){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                          'Errore, le password non coincidono!'), backgroundColor: Colors.red),);
                                }
                                else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                          'Dati salvati con successo!'), backgroundColor: Colors.green,));
                                  toggleRegistration();
                                }
                              }
                            },
                            child: Text('Invia',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))
                    ),
                    Padding(padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue
                            ),
                            onPressed: () {
                              debugPrint("Provo a registrarmi");
                              toggleRegistration();
                            },
                            child: Text('Annulla',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))
                    )
                  ],
                ),
              )
          )
      ),
    );
  }

}