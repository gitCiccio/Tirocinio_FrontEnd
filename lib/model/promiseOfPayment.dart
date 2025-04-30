import 'package:knock_collector_mobile_application/model/practice.dart';
import 'package:uuid/uuid.dart';

class PromiseOfPayment{
  final String promiseOfPaymentId;
  final double amount;
  final DateTime dateOfIssue;
  final DateTime accrualDate;

  PromiseOfPayment({required this.promiseOfPaymentId, required this.amount, required this.dateOfIssue, required this.accrualDate});

  factory PromiseOfPayment.fromJson(Map<String, dynamic> json){
    return PromiseOfPayment(
        promiseOfPaymentId: json['promiseOfPaymentId'],
        amount: json['amount'],
        dateOfIssue: DateTime.parse(json['dateOfIssue']),  // Assicurati che le date siano correttamente deserializzate
        accrualDate: DateTime.parse(json['accrualDate'])
    );
  }

  Map<String,dynamic>toJson(){
    return {
      'promiseOfPaymentId': promiseOfPaymentId,
      'amount': amount,
      'dateOfIssue': dateOfIssue.toIso8601String(),
      'accrualDate': accrualDate.toIso8601String()
    };
  }
}