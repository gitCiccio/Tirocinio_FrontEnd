import 'package:flutter/material.dart';
import 'package:knock_collector_mobile_application/pages/admin_page.dart';
import 'package:knock_collector_mobile_application/second_pages/popup_dialog.dart';
import 'package:knock_collector_mobile_application/service/login_service.dart';
import 'package:uuid/uuid.dart';

import '../pages/practice_page.dart';

class SecondLoginPage extends StatefulWidget {


  final VoidCallback? registrationForm;

  const SecondLoginPage({this.registrationForm, super.key});

  @override
  State<StatefulWidget> createState() {
    return _SecondLoginPageState();
  }
}

class _SecondLoginPageState extends State<SecondLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  final LoginService _loginService = LoginService();


  bool _obscurePassword = true;

  void _showOtpDialog(BuildContext context){
    showDialog(context: context, builder: (context) => OtpDialog(email: _emailController.text));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login page',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: const Color(0xFF0743C2),
        shadowColor: Colors.black,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF0743C2),
                    width: 5,
                  ),
                ),
                child: const Icon(Icons.person, size: 100),
              ),
            ),

            // Form con validazione
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Insert your email address',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Empty field';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Insert your password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Empty field';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: TextButton(
                onPressed: () async {
                  final result = await _loginService.getOtp(_emailController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result),
                      backgroundColor: result.toLowerCase().contains("otp inviato") ? Colors.green : Colors.red, // Puoi cambiarlo a seconda del risultato
                    ),
                  );
                  if(result.toLowerCase().contains("otp inviato")){
                    await Future.delayed(Duration(seconds: 1));
                    _showOtpDialog(context);
                  }

                  //Se l'otp è accettato allora passa alla pagina di registrazione inserendo già la mail
                  //Invia dopo l'invio dei dati ritorni alla pagina di login
                },
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Bottone login
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF0743C2),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final email = _emailController.text;
                    final password = _passwordController.text;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Login in progress...'),
                        backgroundColor: Color(0xFF0743C2),
                      ),
                    );

                    final agent = await _loginService.login(email, password);

                    if (agent != null) {

                      // Login riuscito
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Login success!'),
                          backgroundColor: Colors.green,
                          //Passa alla pagina dell'agente o del super agente
                        ),
                      );

                      if(agent.role == "AGENT"){
                        Future.delayed(Duration(seconds: 6), () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => PracticePage()),
                          );
                        });
                      }else if(agent.role == "ADMIN"){
                        Future.delayed(Duration(seconds: 6), () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => AdminPage()),
                          );
                        });
                      }

                    } else {
                      // Login fallito
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Login faild, check your data.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },

                child: const Text('Sign in',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),

            // Bottone registrazione
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF0743C2),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (widget.registrationForm != null) {
                    widget.registrationForm!();
                  }
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
