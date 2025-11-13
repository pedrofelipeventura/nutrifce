import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // 🟢 ADICIONADO
import 'firebase_options.dart';
import 'screens/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🟢 Carrega variáveis do arquivo .env (antes de tudo)
  await dotenv.load(fileName: ".env");

  // 🔥 Inicializa o Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        primarySwatch: Colors.indigo,
      ),
      home: const LoginPage(), // 🚀 Tela inicial continua sendo o login
    );
  }
}
