import 'package:knock_collector_mobile_application/widgets/input_widgets/inputTetField.dart';

class NameWidget extends InputTextWidget{

  NameWidget(super.name, super.innerText, {required super.controller});

  @override
  String? validateInput(String value) {

    if (value.isEmpty) {
      return 'Campo obbligatorio';
    } else if (value.length<2 && value.length<255) {
      return 'Inserisci un dato valido, la lunghezza deve essere almeno di 2 caratteri';
    }
    return null; // Se la validazione è ok
  }
}