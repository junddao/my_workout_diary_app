import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_workout_diary_app/global/model/model_shared_preferences.dart';
import 'package:my_workout_diary_app/global/provider/login_provider.dart';
import 'package:my_workout_diary_app/global/service/kakao_login.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:my_workout_diary_app/global/util/util.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  @override
  Widget build(BuildContext context) {
    return const PageLoginView();
  }
}

class PageLoginView extends StatefulWidget {
  const PageLoginView({Key? key}) : super(key: key);

  @override
  State<PageLoginView> createState() => _PageLoginViewState();
}

class _PageLoginViewState extends State<PageLoginView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            flex: 5,
            child: Center(
              child: Text('마이 헬스 다이어리', style: DSTextStyles.bold24Grey06),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildKakaoLogin(),
                Platform.isIOS ? const SizedBox(height: 20.0) : const SizedBox.shrink(),
                Platform.isIOS ? _buildAppleLogin() : const SizedBox.shrink(),
                const SizedBox(height: 40.0),
                _buildGuestLogin(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildAppleLogin() {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        bool result = await context.read<LoginProvider>().appleLogin();

        if (result == true) {
          Navigator.of(context).pushNamedAndRemoveUntil('PageTabs', (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('로그인 실패')));
        }
      },
      child: Container(
        width: size.width - 40,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(width: 22),
            Icon(
              FontAwesomeIcons.apple,
              size: 24,
              color: DSColors.white,
            ),
            Spacer(),
            Text('Apple로 로그인', style: DSTextStyles.regular18white),
            Spacer(),
            SizedBox(width: 24),
            SizedBox(width: 22),
          ],
        ),
      ),
    );
  }

  _buildKakaoLogin() {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        bool result = await context.read<LoginProvider>().kakaoLogin();

        if (result == true) {
          Navigator.of(context).pushNamedAndRemoveUntil('PageTabs', (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('로그인 실패')));
        }
      },
      child: Container(
        width: size.width - 40,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.yellow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 22),
            Image.asset(
              "assets/images/ic_logo_kakao.png",
              width: 24,
              height: 24,
            ),
            const Spacer(),
            const Text('카카오로 로그인', style: DSTextStyles.regular18black),
            const Spacer(),
            const SizedBox(width: 24),
            const SizedBox(width: 22),
          ],
        ),
      ),
    );
  }

  _buildGuestLogin() {
    return Container(
      width: double.infinity,
      height: 50,
      child: Center(
        child: InkWell(
          onTap: () async {
            Navigator.of(context).pushNamedAndRemoveUntil('PageTabs', (route) => false);
          },
          child: const Text('Guest로 둘러보기', style: DSTextStyles.regular12BlackUnderLine),
        ),
      ),
    );
  }
}
