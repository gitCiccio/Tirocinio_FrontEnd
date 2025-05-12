class EmailAndPassword{
  final String email;
  final String password;

  EmailAndPassword({required this.email, required this.password});

  factory EmailAndPassword.fromJson(Map<String, dynamic> json){
    return EmailAndPassword(email: json['email'], password: json['password']);
  }

  Map<String, dynamic>toJson(){
    return {'email': email, 'password': password};
  }
}