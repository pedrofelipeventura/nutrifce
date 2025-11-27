import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = "http://localhost:8080"; // URL do backend

class UserService {
  // Pegar perfil do usuário
  static Future<Map<String, dynamic>> getProfile(String idToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/me?idToken=$idToken'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao buscar perfil: ${response.statusCode}');
    }
  }

  // Criar ou atualizar usuário
  static Future<Map<String, dynamic>> registerUser(String idToken, Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/register?idToken=$idToken'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao registrar usuário: ${response.statusCode}');
    }
  }

  // Deletar usuário
  static Future<Map<String, dynamic>> deleteUser(String idToken) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/user/delete?idToken=$idToken'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao deletar usuário: ${response.statusCode}');
    }
  }
}
