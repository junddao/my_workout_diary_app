import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLogin {
  @override
  Future<User?> login() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final authResult = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      return authResult.user;
    } catch (e) {
      print('error');
      throw Exception();
    }
  }

  @override
  Future<bool> logout() async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }
}
