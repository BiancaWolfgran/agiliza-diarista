import 'package:firebase_auth/firebase_auth.dart';
import 'package:agilizadiarista/model/login_model.dart';

class LoginController {
  final LoginModel _model = LoginModel();

  Future<String?> signInWithGoogle() async {
    try {
      User? user = await _model.signInWithGoogle();
      if (user == null) {
        throw Exception('Google Sign-In failed');
      }

      bool isFirstTime = await _model.isFirstTime(user);
      return isFirstTime ? 'first_time' : await _model.getUserType(user);
    } catch (e) {
      print('Error during Google Sign-In: $e');
      return null;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    // Other logout operations if necessary
  }
}

