import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:my_workout_diary_app/global/enum/socail_type.dart';
import 'package:my_workout_diary_app/global/model/model_user.dart';
import 'package:my_workout_diary_app/global/provider/parent_provider.dart';
import 'package:my_workout_diary_app/global/service/api_service.dart';
import 'package:my_workout_diary_app/global/service/apple_login.dart';
import 'package:my_workout_diary_app/global/service/kakao_login.dart';

class LoginProvider extends ParentProvider {
  final KakaoLogin _kakaoLogin = KakaoLogin();
  final AppleLogin _appleLogin = AppleLogin();
  bool isLogined = false;

  late ModelUser user;

  Future<bool> kakaoLogin() async {
    setStateBusy();

    isLogined = await _kakaoLogin.login();
    if (isLogined) {
      kakao.User? kakaoUser = await kakao.UserApi.instance.me();

      // server에서 custom token 을 얻는 부분
      final customToken = await createCustomToken({
        'uid': kakaoUser.id.toString(),
        'name': kakaoUser.kakaoAccount!.profile!.nickname ?? '',
        'email': kakaoUser.kakaoAccount!.email ?? '',
        'photoURL': kakaoUser.kakaoAccount!.profile!.profileImageUrl ?? '',
      });
      print(customToken);

      UserCredential? result = await FirebaseAuth.instance.signInWithCustomToken(customToken);
      User? fbUser = result.user;
      user = ModelUser(
        email: fbUser!.email ?? '',
        nickname: fbUser.displayName ?? '',
        socialType: "kakao",
      );
    }

    setStateIdle();
    return isLogined;
  }

  Future<void> kakaoLogout() async {
    setStateBusy();
    await _kakaoLogin.logout();
    await FirebaseAuth.instance.signOut();
    isLogined = false;

    setStateIdle();
  }

  Future<String> createCustomToken(Map<String, dynamic> user) async {
    final String url = 'http://192.168.1.82:3000/auth/kakao';
    final customTokenResponse = await ApiService().postWithOutToken(url, user);

    return customTokenResponse['token'];
  }

  Future<bool> appleLogin() async {
    setStateBusy();
    try {
      User? fbUser = await _appleLogin.login();
      if (fbUser != null) {
        user = ModelUser(
          email: fbUser.email ?? '',
          nickname: fbUser.displayName ?? '',
          socialType: "apple",
        );
      }

      setStateIdle();
      return true;
    } catch (e) {
      return false;
    }
  }
}
