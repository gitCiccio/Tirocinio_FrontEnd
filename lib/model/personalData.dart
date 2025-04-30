import 'package:uuid/uuid.dart';

class PersonalData{
  final String id;
  final String name;
  final String surname;
  final String taxCode;
  final DateTime dateOfBirth;
  final String? vat;

  PersonalData({required this.id, required this.name, required this.surname, required this.taxCode, required this.dateOfBirth, required this.vat});

  factory PersonalData.fromJson(Map<String, dynamic> json){
    return PersonalData(
        id: json['id'],
        name: json['name'],
        surname: json['surname'],
        taxCode: json['taxCode'],
        dateOfBirth: DateTime.parse(json['dateOfBirth']),
        vat: json['vat']
    );
  }

  Map<String,dynamic>toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'taxCode': taxCode,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'vat': vat
    };
  }
}