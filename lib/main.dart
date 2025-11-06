import 'package:flutter/material.dart';
import 'screens/login_page.dart';

void main() {
  runApp(const NutriFCEApp());
}

class NutriFCEApp extends StatelessWidget {
  const NutriFCEApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriFCE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo, // cor principal do app
      ),
      home: const LoginPage(),
    );
  }
}
