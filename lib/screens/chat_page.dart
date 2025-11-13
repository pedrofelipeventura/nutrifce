import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 🔐 O token agora vem do arquivo .env (NUNCA coloque ele aqui no código!)
final String huggingFaceToken = dotenv.env['HUGGING_FACE_TOKEN'] ?? "";

// Função para conversar com o Hugging Face (modelo Blenderbot)
Future<String> sendMessageToHuggingFace(String userMessage) async {
  const modelUrl =
      "https://api-inference.huggingface.co/models/facebook/blenderbot-400M-distill";

  if (huggingFaceToken.isEmpty) {
    return "Erro: token do Hugging Face não configurado.";
  }

  try {
    final response = await http.post(
      Uri.parse(modelUrl),
      headers: {
        "Authorization": "Bearer $huggingFaceToken",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"inputs": userMessage}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final reply = data[0]?["generated_text"];
      return reply ?? "Desculpe, não entendi.";
    } else {
      print("Erro ${response.statusCode}: ${response.body}");
      return "Erro ${response.statusCode}: ${response.body}";
    }
  } catch (e) {
    print("Erro de conexão: $e");
    return "Erro de conexão ou timeout.";
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
      responseText = await sendMessageToHuggingFace(
        "O usuário enviou uma foto relacionada à dieta. Dê sugestões nutricionais considerando que pode ser uma refeição.",
      );
    } else {
      responseText = await sendMessageToHuggingFace(text!);
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
        title: const Text("Chat com IA (Hugging Face)"),
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
                  alignment: msg.fromUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
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
                hintText: "Fale com a IA sobre sua dieta...",
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

