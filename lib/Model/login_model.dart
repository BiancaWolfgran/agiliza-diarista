import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
    if (googleAccount == null) {
      return null;
    }

    final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<bool> isFirstTime(User user) async {
    var userDoc = await _firestore.collection('users').doc(user.uid).get();
    return !userDoc.exists;
  }

  Future<String?> getUserType(User user) async {
    var userDoc = await _firestore.collection('users').doc(user.uid).get();
    if (userDoc.exists) {
      var data = userDoc.data();
      return data?['tipoUsuario'] as String?;
    }
    return null;
  }
}
