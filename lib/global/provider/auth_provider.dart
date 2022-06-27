import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:my_workout_diary_app/global/enum/socail_type.dart';
import 'package:my_workout_diary_app/global/model/common/model_response_common.dart';
import 'package:my_workout_diary_app/global/model/model_shared_preferences.dart';
import 'package:my_workout_diary_app/global/model/user/model_request_sign_in.dart';
import 'package:my_workout_diary_app/global/model/user/model_response_sign_in.dart';
import 'package:my_workout_diary_app/global/model/user/model_user.dart';
import 'package:my_workout_diary_app/global/provider/parent_provider.dart';
import 'package:my_workout_diary_app/global/provider/user_provider.dart';
import 'package:my_workout_diary_app/global/service/api_service.dart';
import 'package:my_workout_diary_app/global/service/apple_login.dart';
import 'package:my_workout_diary_app/global/service/kakao_login.dart';
import 'package:my_workout_diary_app/global/util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ParentProvider {
  final KakaoLogin _kakaoLogin = KakaoLogin();
  final AppleLogin _appleLogin = AppleLogin();
  SocialType loginSocial = SocialType.none;

  Future<bool> kakaoLogin() async {
    setStateBusy();

    try {
      bool result = await _kakaoLogin.login();
      if (result == false) {
        logger.d('kakao login error');
        setStateIdle();
        return false;
      }

      kakao.User? kakaoUser = await kakao.UserApi.instance.me();

      // server에서 custom token 을 얻는 부분
      final customToken = await createCustomToken({
        'uid': kakaoUser.id.toString(),
        'name': kakaoUser.kakaoAccount!.profile!.nickname ?? '',
        'email': kakaoUser.kakaoAccount!.email ?? '',
        'photoURL': kakaoUser.kakaoAccount!.profile!.profileImageUrl ?? '',
      });
      if (customToken == null) {
        logger.d('get customToken error');
        return false;
      }

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCustomToken(customToken);

      User? fbUser = userCredential.user;
      if (fbUser == null) {
        logger.d('get firebase user error');
      }
      // firebase 유저 가져와서 서버에 로그인 합시다.
      result = await signIn(fbUser!.email!);
      if (result == false) {
        return false;
      }

      logger.d('kakao sign in success');
      loginSocial = SocialType.kakao;
      setStateIdle();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> createCustomToken(Map<String, dynamic> user) async {
    const String url = '/user/kakao';
    try {
      final result = await ApiService().postWithOutToken(url, user);
      final customTokenResponse = result['data'].first;

      return customTokenResponse['fbCustomToken'];
    } catch (e) {
      throw Exception();
    }
  }

  Future<bool> signIn(String email) async {
    try {
      ModelRequestSignIn modelRequestSignIn = ModelRequestSignIn(email: email);
      const String url = '/user/signin';
      Map<String, dynamic> _data = await ApiService().postWithOutToken(url, modelRequestSignIn.toMap());
      ModelResponseSignIn modelResponseSignIn = ModelResponseSignIn.fromMap(_data);
      ModelSignIn modelSignIn = modelResponseSignIn.data!.first;
      await ModelSharedPreferences.writeToken(modelSignIn.accessToken);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> appleLogin() async {
    setStateBusy();
    try {
      User? fbUser = await _appleLogin.login();

      if (fbUser == null) {
        logger.d('get firebase user error');
      }
      // firebase 유저 가져와서 서버에 로그인 합시다.
      bool result = await signIn(fbUser!.uid);
      if (result == false) {
        return false;
      }

      logger.d('apple sign in success');
      loginSocial = SocialType.apple;
      setStateIdle();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateProfile() async {
    try {
      const String url = '/user/drop';
      Map<String, dynamic> result = await ApiService().get(url);
      ModelResponseCommon modelResponseCommon = ModelResponseCommon.fromMap(result);
      if (modelResponseCommon.success == false) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signOut() async {
    setStateBusy();
    try {
      setStateBusy();
      bool result = false;

      if (loginSocial == SocialType.kakao) {
        result = await _kakaoLogin.logout();
      }
      if (result == false) {
        return false;
      }

      loginSocial = SocialType.none;
      await FirebaseAuth.instance.signOut();
      await ModelSharedPreferences.removeAll();

      setStateIdle();
      return true;
    } catch (e) {
      setStateIdle();
      return false;
    }
  }

  Future<bool> drop() async {
    try {
      setStateBusy();
      const String url = '/user/drop';
      Map<String, dynamic> result = await ApiService().get(url);
      ModelResponseCommon modelResponseCommon = ModelResponseCommon.fromMap(result);
      if (modelResponseCommon.success == false) {
        setStateIdle();
        return false;
      }
      setStateIdle();
      return true;
    } catch (e) {
      setStateIdle();
      return false;
    }
  }
}
