import 'package:uuid/uuid.dart';

class CityHall{
  final String id;
  final String city_name;
  final String province;
  final String region;
  final String zip_code;

  CityHall({required this.id, required this.city_name, required this.province, required this.region, required this.zip_code});

  factory CityHall.fromJson(Map<String, dynamic> json){
    return CityHall(
        id: json['id'],
        city_name: json['city_name'],
        province: json['province'],
        region: json['region'],
        zip_code: json['zip_code']
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'city_name': city_name,
      'province': province,
      'region': region,
      'zip_code': zip_code
    };
  }
}