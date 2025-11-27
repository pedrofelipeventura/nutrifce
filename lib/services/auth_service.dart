import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
static Future<String?> getIdToken() async {
User? user = FirebaseAuth.instance.currentUser;
if (user == null) return null;
return await user.getIdToken();
}

// 🔹 Método de login com email e senha
static Future<User?> login(String email, String password) async {
try {
UserCredential credential = await FirebaseAuth.instance
.signInWithEmailAndPassword(email: email, password: password);
return credential.user;
} on FirebaseAuthException catch (e) {
print('Erro ao logar: ${e.message}');
return null;
}
}
}
