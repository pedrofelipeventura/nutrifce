// lib/screens/cadastro_usuario_page.dart
import 'package:flutter/material.dart';
import 'cadastro_usuario2_page.dart';

class CadastroUsuarioPage extends StatelessWidget {
const CadastroUsuarioPage({super.key});

@override
Widget build(BuildContext context) {
final nomeController = TextEditingController();
final emailController = TextEditingController();
final telefoneController = TextEditingController();
final senhaController = TextEditingController();


return Scaffold(
  appBar: AppBar(
    backgroundColor: Colors.white,
    foregroundColor: Colors.indigo,
    elevation: 0,
    automaticallyImplyLeading: true,
  ),
  body: Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Cadastro de usuário',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 30),

            // Nome
            campoComRotulo('Nome:', nomeController),
            const SizedBox(height: 15),

            // Email
            campoComRotulo('Email:', emailController,
                tipo: TextInputType.emailAddress),
            const SizedBox(height: 15),

            // Telefone
            campoComRotulo('Telefone:', telefoneController,
                tipo: TextInputType.phone),
            const SizedBox(height: 15),

            // Senha
            campoComRotulo('Senha:', senhaController,
                tipo: TextInputType.visiblePassword, obscure: true),
            const SizedBox(height: 40),

            // Botão Avançar
            SizedBox(
              width: 160,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black, width: 1.5),
                  elevation: 3,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CadastroUsuario2Page(),
                    ),
                  );
                },
                child: const Text(
                  'Avançar',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
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

// Campo com rótulo padrão
Widget campoComRotulo(String rotulo, TextEditingController controller,
{TextInputType tipo = TextInputType.text, bool obscure = false}) {
return Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
rotulo,
style: const TextStyle(
fontSize: 18,
color: Colors.indigo,
),
),
const SizedBox(height: 5),
Container(
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(8),
border: Border.all(color: Colors.black, width: 1.3),
),
child: TextField(
controller: controller,
obscureText: obscure,
keyboardType: tipo,
decoration: const InputDecoration(
contentPadding: EdgeInsets.symmetric(horizontal: 10),
border: InputBorder.none,
),
),
),
],
);
}
}
