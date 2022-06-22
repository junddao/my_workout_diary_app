import 'package:flutter/material.dart';
import 'package:my_workout_diary_app/global/components/ds_calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class PageRecord extends StatefulWidget {
  const PageRecord({Key? key}) : super(key: key);

  @override
  State<PageRecord> createState() => _PageRecordState();
}

class _PageRecordState extends State<PageRecord> {
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
    return SingleChildScrollView(
      child: Column(
        children: [
          ValueListenableBuilder<DateTime?>(
            valueListenable: selectedDays,
            builder: (context, value, child) {
              return DSTableCalendar(selectedDay: value, focusedDay: kToday, onDaySelected: _onDaySelected);
            },
          ),
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
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusTime) {
    print("$selectedDay, $focusTime");
    selectedDays.value = selectedDay;
    selectedEvents.value = _getEventsForDay(selectedDay);
  }
}

List<Event> _getEventsForDay(DateTime day) {
  // Implementation example
  return kEvents[day] ?? [];
}
