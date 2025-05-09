import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knock_collector_mobile_application/service/agentService.dart';
import 'package:knock_collector_mobile_application/widgets/input_widgets/password_widget.dart';

import '../pages/practice_page.dart';
import 'input_widgets/email_widget.dart';
/*
class SignIn extends StatelessWidget{

  final GlobalKey<FormState> _formKey;
  final  _emailController = TextEditingController();
  final  _passwordController = TextEditingController();//Da cambiare
  final VoidCallback toggleRegistration;

  SignIn(this._formKey,  {super.key, required this.toggleRegistration});

  void _goToPracticePage(BuildContext context){
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => PracticePage()));
  }

  void _login(BuildContext context) async {
    if(_formKey.currentState!.validate()){
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      try{
        final agent = await AgentService().login(email, password);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Accesso riuscito! Benvenuto, ${agent.email}'), backgroundColor: Colors.green),
        );
        _goToPracticePage(context);
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login fallito: ${e.toString()}'), backgroundColor: Colors.red),
        );
      }
    }
  }
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
                    EmailWidget(name: 'email', innerText: 'Inserisci la tua email', controller: _emailController, icon: Icon(Icons.email),),
                    PasswordWidget(name: 'password', innerText: 'Inserisci la tua password', controller: _passwordController),
                    Padding(padding: EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {debugPrint("do somethins");},//Da implementare
                        child: Text('Passowrd dimenticata?', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, decoration: TextDecoration.underline, decorationColor: Colors.blue, decorationThickness: 2),),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue
                            ),
                            onPressed: () {
                              // Validare il Form
                              _login(context);
                            },
                            child: Text('Sign in',
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
                            child: Text('Sign up',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))
                    )
                  ],
                ),
              )
          )
      ),
    );
  }

}*/

