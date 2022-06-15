import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:my_workout_diary_app/global/enum/socail_type.dart';
import 'package:my_workout_diary_app/global/model/model_shared_preferences.dart';
import 'package:my_workout_diary_app/global/model/user/model_request_sign_in.dart';
import 'package:my_workout_diary_app/global/model/user/model_response_sign_in.dart';
import 'package:my_workout_diary_app/global/model/user/model_user.dart';
import 'package:my_workout_diary_app/global/provider/parent_provider.dart';
import 'package:my_workout_diary_app/global/service/api_service.dart';
import 'package:my_workout_diary_app/global/service/apple_login.dart';
import 'package:my_workout_diary_app/global/service/kakao_login.dart';

class LoginProvider extends ParentProvider {
  final KakaoLogin _kakaoLogin = KakaoLogin();
  final AppleLogin _appleLogin = AppleLogin();
  bool isLoggedIn = false;

  late ModelUser user;

  Future<bool> kakaoLogin() async {
    setStateBusy();

    bool isKakaoLoggedIn = await _kakaoLogin.login();
    if (isKakaoLoggedIn) {
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
      if (result != null) {
        isLoggedIn = true;
        User? fbUser = result.user;
        await signIn(fbUser!.uid);

        // User? fbUser = result.user;

        // user = ModelUser(
        //   email: fbUser!.email ?? '',
        //   nickname: fbUser.displayName ?? 'no name',
        //   socialType: "kakao",
        // );
        setStateIdle();
        return isLoggedIn;
      }
    }
    isLoggedIn = false;
    setStateIdle();
    return isLoggedIn;
  }

  Future<void> kakaoLogout() async {
    setStateBusy();
    await _kakaoLogin.logout();
    await FirebaseAuth.instance.signOut();
    isLoggedIn = false;

    setStateIdle();
  }

  Future<String> createCustomToken(Map<String, dynamic> user) async {
    final String url = 'http://192.168.1.82:3000/auth/kakao';
    final customTokenResponse = await ApiService().postWithOutToken(url, user);

    return customTokenResponse['token'];
  }

  Future<void> signIn(String fbUid) async {
    ModelRequestSignIn modelRequestSignIn = ModelRequestSignIn(fbUid: fbUid);
    final String url = 'http://192.168.1.82:3000/auth/signin';
    Map<String, dynamic> _data = await ApiService().postWithOutToken(url, modelRequestSignIn.toMap());
    ModelResponseSignIn modelResponseSignIn = ModelResponseSignIn.fromMap(_data);
    await ModelSharedPreferences.writeToken(modelResponseSignIn.accessToken);
  }

  Future<bool> appleLogin() async {
    setStateBusy();
    try {
      User? fbUser = await _appleLogin.login();
      if (fbUser != null) {
        isLoggedIn = true;
        user = ModelUser(
          email: fbUser.email ?? '',
          nickname: fbUser.displayName ?? '',
          socialType: "apple",
        );
        setStateIdle();
        return isLoggedIn;
      } else {
        isLoggedIn = false;
        setStateIdle();
        return isLoggedIn;
      }
    } catch (e) {
      return false;
    }
  }
}
