import 'package:flutter/material.dart';
import 'package:my_workout_diary_app/global/model/model_shared_preferences.dart';
import 'package:my_workout_diary_app/global/style/constants.dart';
import 'package:my_workout_diary_app/page_tabs.dart';
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
    return const PageHomeView();
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
      // 토큰 가져오는 api 호출
      Navigator.of(context).pushNamedAndRemoveUntil('PageLogin', (route) => false);
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
    return const PageTabs();
  }
}
