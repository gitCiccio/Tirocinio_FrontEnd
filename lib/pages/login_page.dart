import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knock_collector_mobile_application/pages/practice_page.dart';
import 'package:knock_collector_mobile_application/second_pages/login_page_two.dart';
import 'package:knock_collector_mobile_application/second_pages/registration_form.dart';
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
  
  bool registration = false;

  void toggleRegistration() {
    setState(() {
      registration = !registration;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (!registration) {
      return SecondLoginPage(
        registrationForm: toggleRegistration,
      );
    } else {
      return RegistrationForm(
        onCancel: toggleRegistration,
      );
    }
  }



}