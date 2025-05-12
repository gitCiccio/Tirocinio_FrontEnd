import 'package:knock_collector_mobile_application/model/personalData.dart';
import 'package:knock_collector_mobile_application/model/practice.dart';
import 'package:uuid/uuid.dart';

import 'address.dart';

class Debtor {
  final String id;
  final String email;
  final String phoneNumber;
  final PersonalData personalData;
  final List<Address> addresses;

  Debtor({required this.id, required this.email, required this.phoneNumber, required this.personalData, required this.addresses});

  factory Debtor.fromJson(Map<String, dynamic> json) {
    return Debtor(
      id: json['id'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      personalData: PersonalData.fromJson(json['personalData']),
      addresses: (json['addresses'] as List).map((addressJson) => Address.fromJson(addressJson)).toList(),
    );
  }

  Map<String, dynamic>toJson(){
    return {
      'id': id,
      'email': email,
      'phoneNumber': phoneNumber,
      'personalData': personalData.toJson(),
      'addresses': addresses.map((address) => address.toJson()).toList()
    };
  }
}


