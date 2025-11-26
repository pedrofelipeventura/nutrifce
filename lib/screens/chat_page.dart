import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

// Função para enviar mensagem ao Ollama usando Qwen 2.5 (1.5B)
Future<String> sendMessageToOllama(String prompt) async {
  const url = "http://127.0.0.1:11434/api/generate";

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "model": "qwen2.5:1.5b", // 👈 modelo rápido e excelente
        "prompt": prompt,
        "stream": false,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["response"] ?? "Sem resposta.";
    } else {
      return "Erro ${response.statusCode}: ${response.body}";
    }
  } catch (e) {
    return "Erro ao conectar ao Ollama: $e";
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<_Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool _isSending = false;

  Future<void> _sendMessage({String? text, File? imageFile}) async {
    if ((text == null || text.isEmpty) && imageFile == null) return;

    setState(() {
      _messages.add(_Message(
        text: text ?? "[foto enviada]",
        fromUser: true,
        image: imageFile,
      ));
      _isSending = true;
    });

    String responseText = "";

    if (imageFile != null) {
      responseText = await sendMessageToOllama(
        "O usuário enviou uma foto de comida. Dê sugestões nutricionais como um nutricionista."
      );
    } else {
      responseText = await sendMessageToOllama(text!);
    }

    setState(() {
      _isSending = false;
      _messages.add(_Message(text: responseText, fromUser: false));
    });
  }

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      await _sendMessage(imageFile: File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat com IA (Qwen 2.5)"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (ctx, i) {
                final msg = _messages[i];
                return Align(
                  alignment:
                      msg.fromUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: msg.fromUser
                          ? Colors.indigo.shade100
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: msg.image != null
                        ? Image.file(msg.image!, height: 200)
                        : Text(msg.text),
                  ),
                );
              },
            ),
          ),
          if (_isSending) const LinearProgressIndicator(),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: _isSending ? null : _pickImage,
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Fale com a IA...",
                border: InputBorder.none,
              ),
              onSubmitted: (text) {
                _sendMessage(text: text);
                _controller.clear();
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _isSending
                ? null
                : () {
                    _sendMessage(text: _controller.text);
                    _controller.clear();
                  },
          ),
        ],
      ),
    );
  }
}

class _Message {
  final String text;
  final bool fromUser;
  final File? image;
  _Message({required this.text, required this.fromUser, this.image});
}
