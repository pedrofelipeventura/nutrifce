import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';
import 'screens/tela_inicial.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Carrega variáveis do arquivo .env
    // Nota: Certifique-se de que .env está listado em 'assets' no pubspec.yaml
    await dotenv.load(fileName: ".env");

    // Inicializa o Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Em caso de erro, imprime no console para facilitar o debug
    debugPrint("ERRO CRÍTICO NA INICIALIZAÇÃO: $e");
    // Se estiver na web, o erro pode aparecer no console do navegador (F12)
  }

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
      home: TelaInicial(),
    );
  }
}
