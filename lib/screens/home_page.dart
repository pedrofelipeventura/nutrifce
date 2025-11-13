import 'package:flutter/material.dart';
import 'package:nutrifce/screens/chat_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar personalizada
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "NutrIFCE",
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.black,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.circle_outlined),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),

      // Corpo
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Bem-vindo..",
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // TODO: ação para acessar dietas
              },
              child: const Text(
                "Acesse suas dietas aqui",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // TODO: ação para acessar evolução
              },
              child: const Text(
                "Acesse sua evolução aqui",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),

      // Barra inferior
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.black, width: 1.0),
          ),
        ),
        child: Row(
          children: [
            // Botão Foto
            Expanded(
              child: InkWell(
                onTap: () {
                  // TODO: ação para abrir câmera ou galeria
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Colors.black, width: 1.0),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Foto",
                      style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Botão Chat
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatPage()),
                  );
                },
                child: Container(
                  height: 60,
                  child: const Center(
                    child: Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

