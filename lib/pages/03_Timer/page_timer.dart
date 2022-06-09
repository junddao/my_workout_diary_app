import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_workout_diary_app/global/enum/item_type.dart';
import 'package:my_workout_diary_app/global/provider/workout_provider.dart';
import 'package:my_workout_diary_app/global/style/constants.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';
import 'package:my_workout_diary_app/pages/03_Timer/components/widget_interval.dart';
import 'package:my_workout_diary_app/pages/03_Timer/components/widget_rest_time.dart';
import 'package:my_workout_diary_app/pages/03_Timer/components/widget_set_interval.dart';
import 'package:my_workout_diary_app/pages/03_Timer/components/widget_set_rest_time.dart';
import 'package:my_workout_diary_app/pages/03_Timer/components/widget_set_workout_time.dart';
import 'package:my_workout_diary_app/pages/03_Timer/components/widget_workout_time.dart';
import 'package:provider/provider.dart';

class PageTimer extends StatefulWidget {
  const PageTimer({Key? key}) : super(key: key);

  @override
  State<PageTimer> createState() => _PageTimerState();
}

class _PageTimerState extends State<PageTimer> {
  @override
  Widget build(BuildContext context) {
    return const PageTimerView();
  }
}

class PageTimerView extends StatefulWidget {
  const PageTimerView({Key? key}) : super(key: key);

  @override
  State<PageTimerView> createState() => _PageTimerViewState();
}

class _PageTimerViewState extends State<PageTimerView> {
  Color unselectedColor = DSColors.white;
  Color selectedColor = DSColors.tomato;
  int selectedGridIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('PagePlay');
        },
        child: const Text('Go!', style: DSTextStyles.bold12White),
      ),
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar() {
    return AppBar(
      title: const Text('타이머'),
      centerTitle: false,
      automaticallyImplyLeading: false,
    );
  }

  _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        settingWidget(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('루틴 설정', style: DSTextStyles.bold18Grey06),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: GridView.count(
                    // shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 0.8,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: List.generate(3, (index) {
                      //item 의 반목문 항목 형성
                      return _buildGridItem(index);
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget settingWidget() {
    Widget widget;
    ItemType item = context.watch<WorkoutProvider>().selectedType;
    switch (item) {
      case ItemType.workout:
        widget = const WidgetSetWorkoutTime();
        break;
      case ItemType.rest:
        widget = const WidgetSetRestTime();
        break;
      case ItemType.interval:
        widget = const WidgetSetInterval();
        break;
      default:
        widget = Container();
    }
    return widget;
  }

  Widget _buildGridItem(int index) {
    Widget widget;
    switch (index) {
      case 0:
        widget = WidgetWorkoutTime();
        break;
      case 1:
        widget = WidgetRestTime();
        break;
      case 2:
        widget = WidgetInterval();
        break;
      default:
        widget = Container();
    }
    return widget;
  }
}
