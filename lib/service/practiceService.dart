import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:knock_collector_mobile_application/model/installment.dart';
import 'package:knock_collector_mobile_application/model/practice.dart';
import 'package:http/http.dart' as http;

class PracticeService{
  Future<List<Practice>> getAgentPractice(String agentId) async {
    final url = Uri.parse('http://localhost:8080/api/practice/practices/agent?agentId=$agentId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      debugPrint('Dati ricevuti: $data');

      return (data as List)
          .map((practiceJson) => Practice.fromJson(practiceJson))
          .toList();
    } else {
      throw Exception("Errore nel caricamento delle pratiche");
    }
  }

  double calcolateCredit(Practice practice){
    double amount = 0.0;
    for(var installment in practice.installment){
      amount+=installment.amount;
    }
    for(var recovery in practice.recovery){
      amount-=recovery.amount;
    }

    return amount;
  }

  Future<void> sendPractice(Practice practice) async {
    var url = Uri.parse("http://localhost:8080/api/practice/add");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(practice.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Pratica inviata con successo!');
      } else {
        print('Errore durante l\'invio della pratica: ${response.statusCode}');
        print('Risposta server: ${response.body}');
      }
    } catch (e) {
      print('Errore nella richiesta HTTP: $e');
    }
  }
}