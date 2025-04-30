import 'package:knock_collector_mobile_application/model/practice.dart';
import 'package:uuid/uuid.dart';

class Recovery{
  final String recovery_id;
  final double amount;
  final DateTime recoveryDate;

  Recovery({required this.recovery_id, required this.amount, required this.recoveryDate});

  factory Recovery.fromJson(Map<String, dynamic> json){
    return Recovery(
        recovery_id: json['recovery_id'],
        amount: json['amount'],
        recoveryDate: DateTime.parse(json['recoveryDate'])
    );
  }

  Map<String, dynamic>toJson(){
    return{
      'recovery_id': recovery_id,
      'amount': amount,
      'recoveryDate': recoveryDate.toIso8601String()
    };
  }
}