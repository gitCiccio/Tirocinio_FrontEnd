
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/agent.dart';

class RegistrationService{
  Future<String> doRegistration(String email, String password) async {
    final url = Uri.parse("http://localhost:8080/api/agent/add");
    final agent = Agent(agentId: '', email: email, password: password, role: 'AGENT');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(agent.toJson()),
    );

    if(response.statusCode == 200){
      return "Registration successful";
    }else{
      return "Registration error";
    }
  }
}