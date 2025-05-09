//Capire come utilizzarlo
class AgentDTO{
  final String token;
  final String role;
  final String email;



  const AgentDTO({required this.token, required this.role, required this.email});

  factory AgentDTO.fromJson(Map<String, dynamic> json){
    return AgentDTO(
        token: json['token'],
        email: json['email'],
        role: json['role']
    );
  }

  Map<String, dynamic>toJson(){
    return {
      'token': token,
      'role': role,
      'email': email,

    };
  }
}