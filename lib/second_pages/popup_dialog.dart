import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knock_collector_mobile_application/second_pages/registration_form.dart';
import 'package:knock_collector_mobile_application/service/agentService.dart';
import 'package:knock_collector_mobile_application/service/login_service.dart';

import '../model/agent.dart';
import '../model/email_and_otp.dart';

class OtpDialog extends StatefulWidget{

  final String email;

  const OtpDialog({super.key, required this.email});

  @override
  _OtpDialogState createState() => _OtpDialogState();
}

class _OtpDialogState extends State<OtpDialog>{

  List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  final _loginService = LoginService();
  final _agentService = AgentService();

  void _submitOtp() async {
    final otp = _controllers.map((c) => c.text).join();
    final emailAndOtp = EmailAndOtp(email: widget.email, otp: otp);

    final result = await _loginService.checkOtp(emailAndOtp);

    if (!mounted) return; // evita errori se il widget è stato smontato

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result),
        backgroundColor: result.toLowerCase().contains("otp valido.")
            ? Colors.green
            : Colors.red,
      ),
    );
    if(result.toLowerCase().contains("otp valido.")){
      Agent agentData = await _agentService.getAgentData(widget.email);
      if(agentData != null){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => RegistrationForm(
                email: agentData.email,
                fieldsAreLocked: true,
                changePassword: true,
              )
          ),
        );
      }
    }
  }


  @override
  void dispose(){
    _controllers.forEach((c) => c.dispose());
    _focusNodes.forEach((f) => f.dispose());
    super.dispose();
  }


  Widget _buildOtpField(int index) {
    return Container(
      width: 50,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if(value.isNotEmpty && index < 3){
            FocusScope.of(context).requestFocus(_focusNodes[index+1]);
          }else if(value.isNotEmpty && index > 0){
            FocusScope.of(context).requestFocus(_focusNodes[index-1]);
          }
        },
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder()
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: const Text('Inserisci codice OTP', style: TextStyle(fontWeight: FontWeight.bold),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, _buildOtpField),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close)),
              IconButton(
                  onPressed: () => _submitOtp(),
                  icon: Icon(Icons.check))
            ],
          )
        ],
      ),
    );
  }


}