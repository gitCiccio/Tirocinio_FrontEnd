import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:knock_collector_mobile_application/model/agent.dart';
import 'package:http/http.dart' as http;

class AgentService{
  Future<Agent> getAgentData(String email) async {
    final url = Uri.parse('http://localhost:8080/api/agent/agent?email=${email}');
    final response = await http.get(url);

    if(response.statusCode == 200){
      // Decodifica la risposta JSON
      final data = jsonDecode(response.body);

      // Stampa il JSON completo
      debugPrint('Risposta JSON: $data');

      return Agent.fromJson(json.decode(response.body));
    }else{
      throw Exception('Errore nel caricamento');
    }
  }


}