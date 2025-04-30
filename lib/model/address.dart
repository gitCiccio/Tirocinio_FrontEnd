import 'package:knock_collector_mobile_application/model/cityHall.dart';
import 'package:uuid/uuid.dart';

import 'debtor.dart';

class Address {
  final String id;
  final String houseNumber;
  final String nameStreet;
  final String typeStreet;
  final CityHall cityHall;

  Address({required this.id, required this.houseNumber, required this.nameStreet, required this.typeStreet, required this.cityHall});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      houseNumber: json['houseNumber'],
      nameStreet: json['nameStreet'],
      typeStreet: json['typeStreet'],
      cityHall: CityHall.fromJson(json['cityHall']),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'houseNumber': houseNumber,
      'nameStreet': nameStreet,
      'typeStreet': typeStreet,
      'cityHall': cityHall.toJson()
    };
  }
}
