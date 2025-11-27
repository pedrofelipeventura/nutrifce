import 'package:flutter/material.dart';
import 'package:nutrifce/services/auth_service.dart';
import 'home_page.dart';
import 'esqueceu_senha_page.dart';

class LoginPage extends StatefulWidget {
const LoginPage({super.key});

@override
State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final emailController = TextEditingController();
final senhaController = TextEditingController();
bool loading = false;

void _login() async {
setState(() => loading = true);
try {
final user = await AuthService.login(
emailController.text.trim(),
senhaController.text.trim(),
);


  if (user != null) {
    final idToken = await AuthService.getIdToken();
    print("ID Token: $idToken"); // Aqui você pode chamar seu backend
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Erro ao logar")),
    );
  }
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Erro: $e")),
  );
} finally {
  setState(() => loading = false);
}


}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
backgroundColor: Colors.white,
foregroundColor: Colors.indigo,
elevation: 0,
),
body: Center(
child: Padding(
padding: const EdgeInsets.all(16.0),
child: SingleChildScrollView(
child: Column(
children: [
const Text(
"NutrIFCE",
style: TextStyle(
fontSize: 32,
fontWeight: FontWeight.bold,
color: Colors.indigo,
),
),
const SizedBox(height: 40),
TextField(
controller: emailController,
decoration: const InputDecoration(labelText: "Email"),
),
const SizedBox(height: 20),
TextField(
controller: senhaController,
decoration: const InputDecoration(labelText: "Senha"),
obscureText: true,
),
const SizedBox(height: 40),
loading
? const CircularProgressIndicator()
: ElevatedButton(
onPressed: _login,
child: const Text("Entrar"),
),
const SizedBox(height: 20),
InkWell(
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => const EsqueceuSenhaPage(),
),
);
},
child: const Text(
"Esqueceu sua senha",
style: TextStyle(
color: Colors.indigo,
decoration: TextDecoration.underline,
),
),
),
],
),
),
),
),
);
}
}
