import 'package:flutter/material.dart';
import 'package:knock_collector_mobile_application/second_pages/login_page_two.dart';
import 'package:knock_collector_mobile_application/service/registration_service.dart';

void main() => runApp(MaterialApp(home: RegistrationForm()));

class RegistrationForm extends StatefulWidget {
  //Inserire il modo per passare la mail e prendere i dati dell'utente tramite email
  final VoidCallback? onCancel;
  final String? email;
  final bool fieldsAreLocked;

  const RegistrationForm({this.onCancel, super.key, this.email, this.fieldsAreLocked = false});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final RegistrationService _registrationService = RegistrationService();

  String _passwordStrength = '';
  Color _strengthColor = Colors.red;

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void initState(){
    super.initState();
    _emailController.text = widget.email ?? '';
  }
  void _toggleVisibility(String field) {
    setState(() {
      if (field == 'password') {
        _obscurePassword = !_obscurePassword;
      } else if (field == 'confirm') {
        _obscureConfirm = !_obscureConfirm;
      }
    });
  }

  void _checkPasswordStrength(String password) {
    final hasUpper = RegExp(r'[A-Z]');
    final hasLower = RegExp(r'[a-z]');
    final hasDigit = RegExp(r'\d');
    final hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    final hasMinLength = password.length >= 8;

    int strength = 0;
    if (hasUpper.hasMatch(password)) strength++;
    if (hasLower.hasMatch(password)) strength++;
    if (hasDigit.hasMatch(password)) strength++;
    if (hasSpecial.hasMatch(password)) strength++;
    if (hasMinLength) strength++;

    setState(() {
      if (strength <= 2) {
        _passwordStrength = 'Password debole';
        _strengthColor = Colors.red;
      } else if (strength == 3 || strength == 4) {
        _passwordStrength = 'Password media';
        _strengthColor = Colors.orange;
      } else {
        _passwordStrength = 'Password forte';
        _strengthColor = Colors.green;
      }
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Inserisci un indirizzo email';
    }

    // Regex per email (semplificata ma efficace)
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email';
    }

    return null; // email valida
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
        Text('Agent registration',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white),),
        centerTitle: true,
        backgroundColor: Color(0xFF0743C2),
        shadowColor: Colors.black,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                  enabled: !widget.fieldsAreLocked,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () => _toggleVisibility('password'),
                    ),
                  ),
                  onChanged: _checkPasswordStrength,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Inserisci your password';
                    if (_passwordStrength == 'Weak password') {
                      return 'The password is not secure enough';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    _passwordStrength,
                    style: TextStyle(color: _strengthColor),
                  ),
              ),
              Padding(
                padding: EdgeInsets.all(2),
                child: TextFormField(
                  controller: _confirmController,
                  obscureText: _obscureConfirm,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () => _toggleVisibility('confirm'),
                    ),
                  ),
                  validator: (value) =>
                  value != _passwordController.text ? 'The passwords do not match' : null,
                ),
              ),
              Padding(
              padding: const EdgeInsets.only(top: 50),
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
                        if (_formKey.currentState?.validate() ?? false) {
                          if(_registrationService.doRegistration(_emailController.text, _passwordController.text) != "Registration successful"){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Registration completed'),
                              backgroundColor: Colors.green,
                              ),
                            );
                            Future.delayed(Duration(seconds: 1), () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SecondLoginPage()));
                            });
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Registration error'),
                              backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      child: Text('Register'),
                  ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
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
                    if (widget.onCancel != null) {
                      widget.onCancel!();
                    }
                  },
                  child: Text('Cancel'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
