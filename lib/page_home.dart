import 'package:flutter/material.dart';
import 'package:my_workout_diary_app/global/model/model_shared_preferences.dart';
import 'package:my_workout_diary_app/global/provider/auth_provider.dart';
import 'package:my_workout_diary_app/global/provider/user_provider.dart';
import 'package:my_workout_diary_app/global/style/constants.dart';
import 'package:my_workout_diary_app/page_tabs.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return PageHomeView();
  }
}

class PageHomeView extends StatefulWidget {
  const PageHomeView({Key? key}) : super(key: key);

  @override
  State<PageHomeView> createState() => _PageHomeViewState();
}

class _PageHomeViewState extends State<PageHomeView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => _isLogin());
  }

  void _isLogin() async {
    String? myToken = await ModelSharedPreferences.readToken();

    if (myToken == '') {
      // 토큰 가져오는 api 호출
      Navigator.of(context).pushNamedAndRemoveUntil('PageLogin', (route) => false);
    } else {
      bool result = await context.read<UserProvider>().getMe();
      if (result == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('유저 정보를 가져오지 못했습니다.'),
          ),
        );
        Navigator.of(context).pushNamedAndRemoveUntil('PageLogin', (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return PageTabs();
  }
}
