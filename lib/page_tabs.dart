import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_workout_diary_app/global/style/constants.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';
import 'package:my_workout_diary_app/pages/02_record/page_record.dart';
import 'package:my_workout_diary_app/pages/03_Timer/page_timer.dart';
import 'package:my_workout_diary_app/pages/04_best_user/page_best_user.dart';
import 'package:my_workout_diary_app/pages/05_User/page_user.dart';

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
  final List _pages = [
    PageRecord(),
    PageTimer(),
    Container(),
    PageBestUser(),
    PageUser(),
  ];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: _bottomNavigationBar(),
      ),
      floatingActionButton: CircleAvatar(
        radius: 30,
        backgroundColor: DSColors.tomato,
        child: Text('운동시작', style: DSTextStyles.bold10White),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _body() {
    return _pages[_selectedIndex];
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (int index) {
        if (index == 2) {
          return;
        }
        setState(() {
          _selectedIndex = index;
        });
      },
      currentIndex: _selectedIndex,
      backgroundColor: DSColors.white02,
      items: const [
        BottomNavigationBarItem(
          // selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: '기록',
        ),
        BottomNavigationBarItem(
          // selectedIcon: Icon(Icons.timer),
          icon: Icon(Icons.timer_outlined),
          label: '타이머',
        ),
        BottomNavigationBarItem(
          // selectedIcon: Icon(Icons.person),
          icon: SizedBox.shrink(),
          label: '',
        ),
        BottomNavigationBarItem(
          // selectedIcon: Icon(Icons.person),
          icon: Icon(Icons.forest_outlined),
          label: '랭커',
        ),
        BottomNavigationBarItem(
          // selectedIcon: Icon(Icons.person),
          icon: Icon(Icons.person_outline),
          label: '내정보',
        ),
      ],
      selectedFontSize: 11,
      unselectedFontSize: 11,
      selectedItemColor: DSColors.blue03,
      unselectedItemColor: DSColors.black04,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    );
  }
}
