import 'package:uuid/uuid.dart';

class PracticeAndAgent{
  final String practiceAndAgentId;
  final String agent;
  final String practice;

  PracticeAndAgent({required this.practiceAndAgentId, required this.agent, required this.practice});

  factory PracticeAndAgent.fromJson(Map<String, dynamic> json){
    return PracticeAndAgent(
        practiceAndAgentId: json['practiceAndAgentId'],
        agent: json['agent'],
        practice: json['practice']
    );
  }

  Map<String, dynamic>toJson(){
    return{
      'practiceAndAgentId': practiceAndAgentId,
      'agent': agent,
      'practice': practice
    };
  }
}