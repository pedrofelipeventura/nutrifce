import 'package:flutter/material.dart';
import 'autenticacao_email_page.dart';
import 'autenticacao_telefone_page.dart';

class EsqueceuSenhaPage extends StatelessWidget {
  const EsqueceuSenhaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,      // Fundo branco
        foregroundColor: Colors.indigo,     // Cor da seta e do título
        elevation: 0,                       // Sem sombra
        automaticallyImplyLeading: true,   // Ativa a seta padrão de voltar
      ),
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
                  fontSize: 18,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AutenticacaoEmailPage(),
                      ),
                    );
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AutenticacaoTelefonePage(),
                      ),
                    );
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

