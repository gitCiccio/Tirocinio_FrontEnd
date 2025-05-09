class EmailAndOtp{
  final String email;
  final String otp;

  EmailAndOtp({required this.email, required this.otp});

  factory EmailAndOtp.fromJson(Map<String, dynamic> json){
    return EmailAndOtp(email: json['email'], otp: json['otp']);
  }

  Map<String, dynamic>toJson(){
    return {'email': email, 'otp': otp};
  }
}