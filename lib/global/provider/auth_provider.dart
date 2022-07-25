import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:my_workout_diary_app/global/enum/socail_type.dart';
import 'package:my_workout_diary_app/global/model/common/model_response_common.dart';
import 'package:my_workout_diary_app/global/model/model_shared_preferences.dart';
import 'package:my_workout_diary_app/global/model/user/model_request_get_token.dart';
import 'package:my_workout_diary_app/global/model/user/model_request_kakao_sign_in.dart';
import 'package:my_workout_diary_app/global/model/user/model_request_sign_in.dart';
import 'package:my_workout_diary_app/global/model/user/model_request_sign_up.dart';
import 'package:my_workout_diary_app/global/model/user/model_response_get_token.dart';
import 'package:my_workout_diary_app/global/model/user/model_response_update.dart';
import 'package:my_workout_diary_app/global/model/user/model_response_sign_in.dart';
import 'package:my_workout_diary_app/global/model/user/model_user.dart';
import 'package:my_workout_diary_app/global/provider/parent_provider.dart';
import 'package:my_workout_diary_app/global/provider/user_provider.dart';
import 'package:my_workout_diary_app/global/service/api_service.dart';
import 'package:my_workout_diary_app/global/service/apple_login.dart';
import 'package:my_workout_diary_app/global/service/email_login.dart';
import 'package:my_workout_diary_app/global/service/kakao_login.dart';
import 'package:my_workout_diary_app/global/util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ParentProvider {
  final KakaoLogin _kakaoLogin = KakaoLogin();
  final AppleLogin _appleLogin = AppleLogin();
  final EmailLogin _emailLogin = EmailLogin();
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

      ModelRequestKakaoSignIn modelRequestKakaoSignIn = ModelRequestKakaoSignIn(
        uid: kakaoUser.id.toString(),
        name: kakaoUser.kakaoAccount!.profile!.nickname ?? '',
        email: kakaoUser.kakaoAccount!.email ?? '',
        profileImage: kakaoUser.kakaoAccount!.profile!.profileImageUrl ?? '',
      );
      final customToken = await createCustomToken(modelRequestKakaoSignIn.toMap());
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
      result = await getToken(fbUser!.email!);
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

  Future<bool> signIn(String email, String password) async {
    try {
      setStateBusy();
      ModelRequestSignIn modelRequestSignIn = ModelRequestSignIn(email: email, password: password);
      const String url = '/user/signin';
      Map<String, dynamic> _data = await ApiService().postWithOutToken(url, modelRequestSignIn.toMap());
      ModelResponseSignIn modelResponseSignIn = ModelResponseSignIn.fromMap(_data);
      ModelSignIn modelSignIn = modelResponseSignIn.data!.first;
      await ModelSharedPreferences.writeToken(modelSignIn.accessToken);
      setStateIdle();
      return true;
    } catch (e) {
      setStateIdle();
      return false;
    }
  }

  Future<bool> signUp(Map<String, dynamic> map) async {
    try {
      ModelRequestSignUp modelRequestSignUp = ModelRequestSignUp.fromMap(map);
      const String url = '/user/signup';
      Map<String, dynamic> _data = await ApiService().postWithOutToken(url, modelRequestSignUp.toMap());
      ModelResponseCommon modelResponseCommon = ModelResponseCommon.fromMap(_data);
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

  Future<bool> getToken(String email) async {
    try {
      setStateBusy();
      ModelRequestGetToken modelRequestGetToken = ModelRequestGetToken(email: email);
      const String url = '/user/get/token';
      Map<String, dynamic> _data = await ApiService().postWithOutToken(url, modelRequestGetToken.toMap());
      ModelResponseGetToken modelResponseGetToken = ModelResponseGetToken.fromMap(_data);
      ModelGetToken modelGetToken = modelResponseGetToken.data!.first;
      await ModelSharedPreferences.writeToken(modelGetToken.accessToken);
      setStateIdle();
      return true;
    } catch (e) {
      setStateIdle();
      return false;
    }
  }

  Future<bool> signInWithApple(Map<String, dynamic> map) async {
    try {
      setStateBusy();
      const String url = '/user/apple';
      Map<String, dynamic> _data = await ApiService().postWithOutToken(url, map);
      ModelResponseCommon modelResponseCommon = ModelResponseCommon.fromMap(_data);
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

  Future<bool> appleLogin() async {
    setStateBusy();
    try {
      User? fbUser = await _appleLogin.login();

      if (fbUser == null) {
        logger.d('get firebase user error');
      }
      // firebase 유저 가져와서 서버에 로그인 합시다.
      Map<String, dynamic> map = {
        'uid': fbUser?.uid.toString(),
        'name': fbUser?.displayName ?? 'no named',
        'email': fbUser?.email ?? '',
        'profileImage': fbUser?.photoURL ?? '',
      };
      bool result = await signInWithApple(map);
      if (result == false) {
        return false;
      }

      // firebase 유저 가져와서 서버에 로그인 합시다.
      result = await getToken(fbUser!.email!);
      if (result == false) {
        return false;
      }

      logger.d('apple sign in success');
      loginSocial = SocialType.apple;
      setStateIdle();
      return true;
    } catch (e) {
      setStateIdle();
      return false;
    }
  }

  Future<bool> emailSignUp({required email, required password, required name}) async {
    setStateBusy();
    try {
      // firebase 로그인 또는 가입 하고
      User? fbUser = await _emailLogin.signUp(email: email, password: password);

      if (fbUser == null) {
        logger.d('get firebase user error');
      }

      ModelRequestSignUp modelRequestSignUp = ModelRequestSignUp(
        uid: fbUser?.uid.toString() ?? '',
        email: fbUser?.email ?? '',
        social: 'email',
        name: name,
        password: password,
        profileImage: '',
      );

      // 서버에 가입 호출
      bool result = await signUp(modelRequestSignUp.toMap());
      if (result == false) {
        return false;
      }

      // firebase 유저 가져와서 서버에 로그인 합시다.
      result = await signIn(fbUser!.email!, password);
      if (result == false) {
        return false;
      }

      logger.d('email sign in success');
      loginSocial = SocialType.email;
      setStateIdle();
      return true;
    } catch (e) {
      setStateIdle();
      return false;
    }
  }

  Future<bool> emailSignIn({required email, required password}) async {
    setStateBusy();
    try {
      // firebase 로그인 또는 가입 하고
      User? fbUser = await _emailLogin.signIn(email: email, password: password);

      if (fbUser == null) {
        logger.d('get firebase user error');
        return false;
      }

      // 서버에 가입 호출
      bool result = await signIn(fbUser.email ?? '', password);
      if (result == false) {
        return false;
      }

      logger.d('email sign in success');
      loginSocial = SocialType.email;
      setStateIdle();
      return true;
    } catch (e) {
      setStateIdle();
      return false;
    }
  }

  Future<bool> signOut() async {
    setStateBusy();
    try {
      setStateBusy();
      bool result = false;
      await _kakaoLogin.logout();
      // if (loginSocial == SocialType.kakao) {
      //   result = await _kakaoLogin.logout();
      // }
      // if (result == false) {
      //   return false;
      // }

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
