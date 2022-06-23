import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:my_workout_diary_app/global/components/ds_calendar.dart';
import 'package:my_workout_diary_app/global/enum/view_state.dart';
import 'package:my_workout_diary_app/global/model/record/model_request_get_records.dart';
import 'package:my_workout_diary_app/global/provider/record_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

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
      ModelRequestGetRecords reqeustGetRecords = ModelRequestGetRecords(
        startDate: startDate,
        endDate: DateTime.now(),
      );
      await context.read<RecordProvider>().getRecords(reqeustGetRecords);
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

class _PageMainViewState extends State<PageMainView> {
  ValueNotifier<DateTime?> selectedDays = ValueNotifier(null);
  ValueNotifier<List<Event>> selectedEvents = ValueNotifier(kEvents[kToday] ?? []);
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
      return SingleChildScrollView(
        child: Column(
          children: [
            ValueListenableBuilder<List<Event>>(
                valueListenable: selectedEvents,
                builder: (context, value, _) {
                  return ValueListenableBuilder<DateTime?>(
                    valueListenable: selectedDays,
                    builder: (context, value, child) {
                      return DSTableCalendar(
                          selectedDay: value,
                          focusedDay: kToday,
                          onDaySelected: _onDaySelected,
                          eventLoader: _getEventsForDay);
                    },
                  );
                }),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 200,
              child: ValueListenableBuilder<List<Event>>(
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
                          onTap: () => print('${value[index]}'),
                          title: Text('${value[index]}'),
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
    selectedEvents.value = _getEventsForDay(selectedDay);
  }
}

/// 선택한 날짜 값에 해당하는 Event 값을 꺼내옴
List<Event> _getEventsForDay(DateTime day) {
  // Implementation example
  return kEvents[day] ?? [];
}

// test data
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5):
        List.generate(item % 4 + 1, (index) => Event('Event $item | ${index + 1}'))
}..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}
