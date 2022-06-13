import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:my_workout_diary_app/global/provider/parent_provider.dart';
import 'package:my_workout_diary_app/global/service/api_service.dart';
import 'package:my_workout_diary_app/global/service/kakao_login.dart';
import 'package:my_workout_diary_app/global/service/social_login.dart';

class KakaoLoginProvider extends ParentProvider {
  final SocialLogin _socialLogin = KakaoLogin();
  bool isLogined = false;
  kakao.User? user;

  Future<bool> login() async {
    setStateBusy();
    isLogined = await _socialLogin.login();
    if (isLogined) {
      user = await kakao.UserApi.instance.me();
      final customToken = await createCustomToken({
        'uid': user!.id.toString(),
        'name': user!.kakaoAccount!.profile!.nickname ?? '',
        'email': user!.kakaoAccount!.email ?? '',
        'photoURL': user!.kakaoAccount!.profile!.profileImageUrl ?? '',
      });

      await FirebaseAuth.instance.signInWithCustomToken(customToken);
    }

    setStateIdle();
    return isLogined;
  }

  Future<void> logout() async {
    setStateBusy();
    await _socialLogin.logout();
    await FirebaseAuth.instance.signOut();
    isLogined = false;
    user = null;
    setStateIdle();
  }

  Future<String> createCustomToken(Map<String, dynamic> user) async {
    final String url = '';
    final customTokenResponse = await ApiService().post(url, user);

    return customTokenResponse;
  }
}
