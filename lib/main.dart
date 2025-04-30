import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knock_collector_mobile_application/pages/admin_page.dart';
import 'package:knock_collector_mobile_application/pages/login_page.dart';
import 'package:knock_collector_mobile_application/pages/practice_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope( // Avvolge tutta l'app per usare i provider
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AdminPage()//LoginPage(), // La prima schermata
      ),
    );
  }
}

