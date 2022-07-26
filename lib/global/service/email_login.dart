import 'package:firebase_auth/firebase_auth.dart';

class EmailLogin {
  Future<User?> signIn({required email, required password}) async {
    try {
      final authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return authResult.user;
    } catch (e) {
      print('error');
      throw Exception();
    }
  }

  Future<User?> signUp({required email, required password}) async {
    try {
      final authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return authResult.user;
    } catch (e) {
      print('error');
      throw Exception();
    }
  }
}
