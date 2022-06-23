import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:my_workout_diary_app/global/components/ds_calendar.dart';
import 'package:my_workout_diary_app/global/enum/view_state.dart';
import 'package:my_workout_diary_app/global/model/record/model_record.dart';
import 'package:my_workout_diary_app/global/model/record/model_record_event.dart';
import 'package:my_workout_diary_app/global/model/record/model_request_get_records.dart';
import 'package:my_workout_diary_app/global/provider/record_provider.dart';
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
  LinkedHashMap<DateTime, List<ModelRecord>>? kEvents;
  ValueNotifier<List<ModelRecord>> selectedEvents = ValueNotifier([]);
  ValueNotifier<DateTime?> selectedDays = ValueNotifier(null);

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
    return Consumer<RecordProvider>(builder: (_, watch, __) {
      if (watch.state == ViewState.Busy) {
        return Center(child: CircularProgressIndicator());
      }
      kEvents = watch.getEvents();
      return SingleChildScrollView(
        child: Column(
          children: [
            ValueListenableBuilder<List<ModelRecord>>(
                valueListenable: selectedEvents,
                builder: (context, value, _) {
                  return ValueListenableBuilder<DateTime?>(
                    valueListenable: selectedDays,
                    builder: (context, value, child) {
                      return DSTableCalendar(
                          selectedDay: value,
                          focusedDay: DateTime.now(),
                          onDaySelected: _onDaySelected,
                          eventLoader: _getEventsForDay);
                    },
                  );
                }),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 200,
              child: ValueListenableBuilder<List<ModelRecord>>(
                valueListenable: selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          onTap: () => print('${value[index].workoutTime}'),
                          title: Text('${value[index].workoutTime}'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  /// 특정 날짜를 선택했을 때, ValueNotifier에 값을 넣어 캘린더와 하단 리스트를 재 빌드 시킴
  void _onDaySelected(DateTime selectedDay, DateTime _) {
    selectedDays.value = selectedDay;
    selectedEvents.value = kEvents![selectedDay] ?? [];
  }

  List<ModelRecord> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents?[day] ?? [];
  }
}
