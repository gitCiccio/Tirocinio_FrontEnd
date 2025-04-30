import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:knock_collector_mobile_application/model/agent.dart';
import 'package:http/http.dart' as http;

class AgentService{
  Future<Agent> getAgentData() async {
    final url = Uri.parse('http://localhost:8080/api/agent/agent?email=ciccio@gmail.com');
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

  Future<Agent> login(String email, String password) async {
    final url = Uri.parse('http://localhost:8080/api/agent/login');
    final agent = Agent(agentId: '', email: email, password: password, role: '');
    final response = await http.post(
        url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(agent.toJson()),
    );

    if(response.statusCode == 200){
      return Agent.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Email o password errati');
    }
  }
}