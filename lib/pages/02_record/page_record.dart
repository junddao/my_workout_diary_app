import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_workout_diary_app/global/components/ds_calendar.dart';
import 'package:my_workout_diary_app/global/enum/condition_type.dart';
import 'package:my_workout_diary_app/global/enum/view_state.dart';
import 'package:my_workout_diary_app/global/model/record/model_record.dart';
import 'package:my_workout_diary_app/global/model/record/model_record_event.dart';
import 'package:my_workout_diary_app/global/model/record/model_request_get_records.dart';
import 'package:my_workout_diary_app/global/provider/record_provider.dart';
import 'package:my_workout_diary_app/global/style/constants.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:my_workout_diary_app/global/style/ds_text_styles.dart';
import 'package:my_workout_diary_app/global/util/extension/datetime.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class PageRecord extends StatefulWidget {
  const PageRecord({Key? key}) : super(key: key);

  @override
  State<PageRecord> createState() => _PageRecordState();
}

class _PageRecordState extends State<PageRecord> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      int year = DateTime.now().year;
      int month = DateTime.now().month;
      final startDate = DateTime(year, month, 1);
      ModelRequestGetRecords requestGetRecords = ModelRequestGetRecords(
        startDate: startDate,
        endDate: DateTime.now(),
      );
      await context.read<RecordProvider>().getRecords(requestGetRecords);
      context.read<RecordProvider>().setSelectedDay(DateTime.now());
      context.read<RecordProvider>().getEvents();
      context.read<RecordProvider>().setSelectedEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const PageMainView();
  }
}

class PageMainView extends StatefulWidget {
  const PageMainView({Key? key}) : super(key: key);

  @override
  State<PageMainView> createState() => _PageMainViewState();
}

final kToday = DateTime.now();

class _PageMainViewState extends State<PageMainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar() {
    return AppBar(
      title: const Text('메인'),
      centerTitle: false,
      automaticallyImplyLeading: false,
    );
  }

  _body() {
    return Consumer<RecordProvider>(builder: (_, provider, __) {
      if (provider.state == ViewState.Busy) {
        return Center(child: CircularProgressIndicator());
      }

      int totalWorkoutTime = 0;

      provider.selectedEvents.forEach(
        (element) {
          totalWorkoutTime = totalWorkoutTime + element.workoutTime;
        },
      );
      int totalWorkoutMinute = totalWorkoutTime ~/ 60;
      int totalWorkoutSecond = totalWorkoutTime % 60;

      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DSTableCalendar(
                  selectedDay: provider.selectedDay,
                  focusedDay: DateTime.now(),
                  onDaySelected: _onDaySelected,
                  eventLoader: _getEventsForDay),
            ),
            const SizedBox(height: 8.0),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: '이날은 ', style: DSTextStyles.bold14WarmGrey),
                        TextSpan(text: '$totalWorkoutMinute', style: DSTextStyles.bold18Black),
                        TextSpan(text: ' 분 ', style: DSTextStyles.bold14Black),
                        TextSpan(text: '$totalWorkoutSecond', style: DSTextStyles.bold18Black),
                        TextSpan(text: ' 초 ', style: DSTextStyles.bold14Black),
                        TextSpan(text: '운동했어요. ', style: DSTextStyles.bold14WarmGrey),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  // height: 200,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: provider.selectedEvents.length,
                    itemBuilder: (context, index) {
                      var item = provider.selectedEvents[index];

                      return Slidable(
                          key: Key(index.toString()),
                          groupTag: '0',
                          endActionPane: ActionPane(
                            extentRatio: 0.2,
                            motion: const ScrollMotion(),
                            key: Key(item.id),
                            children: [
                              SlidableAction(
                                // An action can be bigger than the others.
                                onPressed: (slidableContext) async {
                                  int year = DateTime.now().year;
                                  int month = DateTime.now().month;
                                  final startDate = DateTime(year, month, 1);
                                  ModelRequestGetRecords requestGetRecords = ModelRequestGetRecords(
                                    startDate: startDate,
                                    endDate: DateTime.now(),
                                  );
                                  var results = Future.wait([
                                    context.read<RecordProvider>().deleteRecord(item.id),
                                    context.read<RecordProvider>().getRecords(requestGetRecords)
                                  ]);

                                  results.then((value) {
                                    if (!value.contains(false)) {
                                      provider.getEvents();
                                      provider.setSelectedEvents();
                                    }
                                  });
                                },
                                flex: 1,
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                label: "삭제",
                              ),
                            ],
                          ),
                          child: _buildRecordListItem(provider.selectedEvents, index));
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
          ],
        ),
      );
    });
  }

  Widget _buildRecordListItem(List<ModelRecord> value, int index) {
    final _time = value[index].startTime.difference(value[index].endTime).inSeconds;
    final _workoutMinute = _time ~/ 60;
    final _workoutSecond = _time % 60;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: DSColors.greyish),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(12),
              child: getConditionImage(value[index].condition),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('$_workoutMinute', style: DSTextStyles.bold18WarmGrey),
                      Text(' 분', style: DSTextStyles.regular12WarmGrey),
                      SizedBox(width: 8),
                      Text('$_workoutSecond', style: DSTextStyles.bold14WarmGrey),
                      Text(' 초', style: DSTextStyles.regular12WarmGrey),
                    ],
                  ),
                  Text('${value[index].startTime.toTimestampString2()} ~ ${value[index].endTime.toTimestampString2()}',
                      style: DSTextStyles.regular12WarmGrey),
                ],
              )),
        ],
      ),
    );
  }

  /// 특정 날짜를 선택했을 때, ValueNotifier에 값을 넣어 캘린더와 하단 리스트를 재 빌드 시킴
  void _onDaySelected(DateTime selectedDay, DateTime _) {
    context.read<RecordProvider>().setSelectedDay(selectedDay);
    context.read<RecordProvider>().setSelectedEvents();
    // setState(() {});
  }

  List<ModelRecord> _getEventsForDay(DateTime day) {
    // Implementation example
    return context.read<RecordProvider>().kEvents?[day] ?? [];
  }

  Widget getConditionImage(ConditionType condition) {
    late Image child;
    switch (condition) {
      case ConditionType.BD:
        child = Image.asset('assets/images/b1.png');
        break;
      case ConditionType.NB:
        child = Image.asset('assets/images/b2.png');
        break;
      case ConditionType.GD:
        child = Image.asset('assets/images/b3.png');
        break;
      case ConditionType.VG:
        child = Image.asset('assets/images/b4.png');
        break;

      default:
        child = Image.asset('assets/images/b5.png');
        break;
    }

    return child;
  }
}
