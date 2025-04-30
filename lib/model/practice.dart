import 'package:knock_collector_mobile_application/model/debtor.dart';
import 'package:knock_collector_mobile_application/model/installment.dart';
import 'package:knock_collector_mobile_application/model/promiseOfPayment.dart';
import 'package:knock_collector_mobile_application/model/recovery.dart';
import 'package:uuid/uuid.dart';

import 'note.dart';

class Practice{
  final String practice_id;
  final Debtor debtor;
  final double creditToRecover;
  final List<Installment> installment;
  final List<PromiseOfPayment> promiseOfPayment;
  final List<Recovery> recovery;
  final List<Note> notes;

  Practice({required this.practice_id, required this.debtor, required this.creditToRecover, required this.installment, required this.promiseOfPayment, required this.recovery, required this.notes});

  factory Practice.fromJson(Map<String, dynamic> json){
    return Practice(
      practice_id: json['practice_id'],
      debtor: Debtor.fromJson(json['debtor']),  // Usa il costruttore fromJson per Debtor
      creditToRecover: json['creditToRecover'],
      installment: (json['installment'] as List)
          .map((installmentJson) => Installment.fromJson(installmentJson))  // Usa Installment.fromJson
          .toList(),
      promiseOfPayment: (json['promiseOfPayment'] as List)
          .map((promiseOfPaymentJson) => PromiseOfPayment.fromJson(promiseOfPaymentJson))  // Usa PromiseOfPayment.fromJson
          .toList(),
      recovery: (json['recovery'] as List)
          .map((recoveryJson) => Recovery.fromJson(recoveryJson))  // Usa Recovery.fromJson
          .toList(),
      notes: (json['notes'] as List)
        .map((notesJson) => Note.fromJson(notesJson))
        .toList(),
    );
  }

  Map<String, dynamic>toJson(){
    return{
      'practice_id': practice_id,
      'debtor': debtor.toJson(),
      'creditToRecover': creditToRecover,
      'installment': installment.map((installment) => installment.toJson()).toList(),
      'promiseOfPayment': promiseOfPayment.map((promise) => promise.toJson()).toList(),
      'recovery': recovery.map((recovery) => recovery.toJson()).toList(),
      'notes': notes.map((note) => note.toJson()).toList()
    };
  }

  @override
  String toString() => 'Pratica ID: $practice_id, Debitore: ${debtor.personalData.name}';
}