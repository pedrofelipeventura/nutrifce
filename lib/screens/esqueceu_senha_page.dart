import 'package:flutter/material.dart';

class EsqueceuSenhaPage extends StatelessWidget {
  const EsqueceuSenhaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Formas de recuperação\nde senha:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 30),

              // Botão Email
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.black, width: 1.5),
                    elevation: 3,
                  ),
                  onPressed: () {
                    // Aqui você pode adicionar a navegação para a tela de recuperação por email
                  },
                  child: const Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Botão Telefone
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.black, width: 1.5),
                    elevation: 3,
                  ),
                  onPressed: () {
                    // Aqui você pode adicionar a navegação para a tela de recuperação por telefone
                  },
                  child: const Text(
                    'Telefone',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
