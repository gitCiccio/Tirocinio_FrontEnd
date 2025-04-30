import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knock_collector_mobile_application/pages/practice_page.dart';
import 'package:knock_collector_mobile_application/widgets/input_widgets/email_widget.dart';
import 'package:knock_collector_mobile_application/widgets/sign_in.dart';
import 'package:knock_collector_mobile_application/widgets/sign_up.dart';



class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }

}

class _LoginPageState extends State<LoginPage>{
  
  final _formKey = GlobalKey<FormState>();
  bool registration = false;

  void toggleRegistration() {
    debugPrint("Funzione chiamata");
    setState(() {
      registration = !registration;
      debugPrint("Stato della registrazione ${registration}");
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
          Text(!registration ? 'Login page' : 'SignUp Page',
            style:
              TextStyle(
                fontWeight: FontWeight.bold,),
          ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
        body: !registration
            ? SignIn(_formKey, toggleRegistration: toggleRegistration)
            : SignUp(_formKey, toggleRegistration: toggleRegistration)

    );
  }


}