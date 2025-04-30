import 'package:flutter/cupertino.dart';
import 'package:knock_collector_mobile_application/widgets/input_widgets/inputTetField.dart';

class EmailWidget extends InputTextWidget{

  EmailWidget({super.key,
    required String name,
    required String innerText,
    required TextEditingController controller,
    Icon? icon,
  }) : super(name, innerText, controller: controller, icon: icon);

  @override
  String? validateInput(String value) {
    // Validazione per l'email (usando una semplice regex)
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Campo obbligatorio';
    } else if (!regex.hasMatch(value)) {
      return 'Inserisci un\'email valida';
    }
    return null; // Se la validazione è ok
  }
}