import 'package:knock_collector_mobile_application/model/practice.dart';
import 'package:uuid/uuid.dart';

class Installment {
  final String installmentId;
  final double amount;
  final DateTime dateOfIssue;
  final DateTime accrualDate;

  Installment({required this.installmentId, required this.amount, required this.dateOfIssue, required this.accrualDate});

  factory Installment.fromJson(Map<String, dynamic> json) {
    return Installment(
      installmentId: json['installmentId'],
      amount: (json['amount'] as num).toDouble(), // <- sicuro se arriva intero o double
      dateOfIssue: DateTime.parse(json['dateOfIssue']),
      accrualDate: DateTime.parse(json['accrualDate']),
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'installmentId': installmentId,
      'amount': amount,
      'dateOfIssue': dateOfIssue.toIso8601String(),
      'accrualDate': accrualDate.toIso8601String(),
    };
  }
}
