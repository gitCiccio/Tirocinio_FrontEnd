import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:knock_collector_mobile_application/model/email_and_otp.dart';


import '../model/agent.dart';
import '../model/agent_dto.dart';

class LoginService{
  //Inserire qui un agent dto
  Future<AgentDTO?> login(String email, String password) async {
    final url = Uri.parse('http://localhost:8080/api/auth/login');
    final agent = Agent(agentId: '', email: email, password: password, role: '');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(agent.toJson()),
    );


    if(response.statusCode == 200){
      return AgentDTO.fromJson(jsonDecode(response.body));
    }else{
      return null;
    }
  }

  Future<String> getOtp(String email) async {
    final url = Uri.parse("http://localhost:8080/api/agent/reset/request?email=$email");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "Errore: ${response.body}";
      }
    } catch (e) {
      return "Errore di rete.";
    }
  }

  Future<String> checkOtp(EmailAndOtp emailAndOtp) async {
    try{
      final url = Uri.parse("http://localhost:8080/api/agent/checkOtp");
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(emailAndOtp.toJson()));

      if(response.statusCode == 200){
        return "OTP valido.";
      }

      return "otp non valido";

    }catch(e){
      return "otp non valido";
    }
  }


}