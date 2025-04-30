import 'package:uuid/uuid.dart';

class Agent{
  final String agentId;
  final String email;
  final String password;
  final String role;

  Agent({required this.agentId, required this.email, required this.password, required this.role});

  factory Agent.fromJson(Map<String, dynamic> json){
    return Agent(
        agentId: json['agentId'],
        email: json['email'],
        password: json['password'],
        role: json['role']
    );
  }

  Map<String, dynamic>toJson(){
    return {
      'agentId': agentId,
      'email': email,
      'password': password,
      'role': role
    };
  }
}