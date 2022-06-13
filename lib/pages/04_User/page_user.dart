import 'package:flutter/material.dart';
import 'package:my_workout_diary_app/global/provider/kakao_login_provider.dart';
import 'package:provider/provider.dart';

class PageUser extends StatefulWidget {
  const PageUser({Key? key}) : super(key: key);

  @override
  State<PageUser> createState() => _PageUserState();
}

class _PageUserState extends State<PageUser> {
  @override
  Widget build(BuildContext context) {
    return PageUserView();
  }
}

class PageUserView extends StatefulWidget {
  const PageUserView({Key? key}) : super(key: key);

  @override
  State<PageUserView> createState() => _PageUserViewState();
}

class _PageUserViewState extends State<PageUserView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar() {
    return AppBar(
      title: const Text('마이'),
      centerTitle: false,
      automaticallyImplyLeading: false,
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('${context.read<KakaoLoginProvider>().user!.kakaoAccount!.email}'),
        ],
      ),
    );
  }
}
