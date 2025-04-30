import 'package:flutter/material.dart';

class PracticeWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
    child: Container(
      color: Colors.white,
      width: 500,
      alignment: Alignment.center,
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(10)),
          Text('Pratica N: '),
          SizedBox(height: 50),  // Spazio tra i widget
          Text('Debitore'),
          SizedBox(height: 50,),
          ElevatedButton(onPressed: () {debugPrint("Visulizzato");}, child: Text('Visualizza')),
          Padding(padding: EdgeInsets.all(10))
        ],
      ),
    )
    );
  }

}