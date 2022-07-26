import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_workout_diary_app/global/components/ds_two_button_dialog.dart';
import 'package:my_workout_diary_app/global/model/model_shared_preferences.dart';
import 'package:my_workout_diary_app/global/provider/record_provider.dart';
import 'package:my_workout_diary_app/global/service/timer_service.dart';
import 'package:my_workout_diary_app/global/style/constants.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';
import 'package:my_workout_diary_app/global/util/ad_helper.dart';
import 'package:my_workout_diary_app/global/util/util.dart';
import 'package:my_workout_diary_app/pages/02_record/page_record.dart';
import 'package:my_workout_diary_app/pages/03_Timer/page_timer.dart';
import 'package:my_workout_diary_app/pages/04_best_user/page_best_user.dart';
import 'package:my_workout_diary_app/pages/05_User/page_user.dart';
import 'package:provider/provider.dart';
import 'package:my_workout_diary_app/global/util/extension/string.dart';

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

class _PageTabViewState extends State<PageTabView> with WidgetsBindingObserver {
  final List _pages = [
    PageRecord(),
    Container(),
    // PageTimer(),
    Container(),
    PageBestUser(),
    PageUser(),
  ];

  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    createInterstitialAd();
    isDropped();
  }

  void isDropped() async {
    String? token = await ModelSharedPreferences.readToken();
    if (token!.isEmpty) {
      DSDialog.showOneButtonDialog(context: context, title: '탈퇴확인', subTitle: '탈퇴한 유저는 1주일 뒤 재가입 가능합니다.', btnText: "확인")
          .then((value) {
        Navigator.of(context).pushNamedAndRemoveUntil('PageLogin', (route) => false);
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        logger.d('resume');
        context.read<RecordProvider>().setPassedTime();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.paused:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _body(),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: _bottomNavigationBar(),
      ),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _floatingActionButton() {
    return Consumer<RecordProvider>(builder: (_, value, __) {
      return ElevatedButton(
        child: value.time != 0
            ? Text('${value.time ~/ 10}'.toTimeWithMinSec(), style: DSTextStyles.bold10Black)
            : Text('시작?', style: DSTextStyles.bold10White),
        onPressed: () {
          value.isStart ? stopDialog(_, value) : startDialog(_, value);
          // value.isStart ? stopDialog(_, value) : value.start();
        },
        style: ElevatedButton.styleFrom(
          primary: value.time == 0 ? DSColors.blue5 : DSColors.kakao_yellow,
          minimumSize: const Size(60, 60),
          shape: const CircleBorder(),
        ),
      );
    });
  }

  Widget _body() {
    return _pages[_selectedIndex];
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (int index) {
        if (index == 1) {
          timerBottomSheet();
          return;
        }
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

  Future<void> timerBottomSheet() {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          width: SizeConfig.screenWidth,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('PageTimer');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.timer_outlined),
                      SizedBox(
                        height: 8,
                      ),
                      Text('타바타 타이머'),
                    ],
                  ),
                ),
              ),
              VerticalDivider(
                color: DSColors.greyish,
                indent: 2,
                endIndent: 20,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.warning_outlined, color: DSColors.tomato),
                    SizedBox(
                      height: 8,
                    ),
                    Text('작업중!'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  startDialog(BuildContext context, RecordProvider provider) async {
    var result = await DSDialog.showTwoButtonDialog(
      context: context,
      title: '시작',
      subTitle: '운동을 시작하시겠습니까?',
      btn1Text: '아니요,',
      btn2Text: '네,',
    );
    if (result == true) {
      provider.start();
    }
  }

  stopDialog(BuildContext context, RecordProvider provider) async {
    var result = await DSDialog.showTwoButtonDialog(
      context: context,
      title: '앗!',
      subTitle: '기록을 멈추시겠습니까?',
      btn1Text: '아니요,',
      btn2Text: '네,',
    );
    if (result == true) {
      provider.stop();
      Navigator.of(context).pushNamed('PageRecordCondition');
    }
  }
}
