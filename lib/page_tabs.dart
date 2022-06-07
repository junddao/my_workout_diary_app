import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_workout_diary_app/pages/02_Main/page_main.dart';
import 'package:my_workout_diary_app/pages/03_Timer/page_timer.dart';
import 'package:my_workout_diary_app/pages/04_User/page_user.dart';

class PageTabs extends StatefulWidget {
  const PageTabs({Key? key}) : super(key: key);

  @override
  State<PageTabs> createState() => _PageTabsState();
}

class _PageTabsState extends State<PageTabs> {
  @override
  Widget build(BuildContext context) {
    return const PageTabView();
  }
}

class PageTabView extends StatefulWidget {
  const PageTabView({Key? key}) : super(key: key);

  @override
  State<PageTabView> createState() => _PageTabViewState();
}

class _PageTabViewState extends State<PageTabView> {
  final List _pages = const [
    PageMain(),
    PageTimer(),
    PageUser(),
  ];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.plus_one),
      ),
      body: _body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _body() {
    return _pages[_selectedIndex];
  }

  Widget _bottomNavigationBar() {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      selectedIndex: _selectedIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: '메인',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.timer),
          icon: Icon(Icons.timer_outlined),
          label: '타이머',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.person),
          icon: Icon(Icons.person_outline),
          label: '내정보',
        ),
      ],
    );
  }
}
