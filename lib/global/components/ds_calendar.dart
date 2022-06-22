import 'dart:io';

import 'package:intl/intl.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

class DSCalendar extends StatelessWidget {
  DSCalendar({
    Key? key,
    required this.onDaySelected,
    this.initialDays,
    this.singleSelect = true,
    this.calendarFormat = CalendarFormat.month,
  }) : _widget = _DSCalendar(
          onDaySelected: onDaySelected,
          selectedDays: ValueNotifier<List<DateTime>>(initialDays ?? []),
          singleSelect: singleSelect,
          calendarFormat: calendarFormat,
        );

  late void Function(List<DateTime> selected) onDaySelected;
  late void Function(List<DateTime> selected) onSelected;
  List<DateTime>? initialDays;
  final bool singleSelect;
  CalendarFormat calendarFormat = CalendarFormat.month;
  late Widget _widget;
  @override
  Widget build(BuildContext context) {
    return _widget;
  }
}

class _DSCalendar extends StatelessWidget {
  _DSCalendar({
    Key? key,
    required this.onDaySelected,
    required this.selectedDays,
    this.singleSelect = true,
    this.calendarFormat = CalendarFormat.month,
  }) : super(key: key);

  final bool singleSelect;
  CalendarFormat calendarFormat;
  final void Function(List<DateTime> selectedDay) onDaySelected;
  DateTime _focusedDay = DateTime.now();
  late ValueNotifier<List<DateTime>> selectedDays;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
      color: Colors.transparent,
      child: ValueListenableBuilder<List<DateTime>?>(
        valueListenable: selectedDays,
        builder: (context, value, child) {
          return _defaultTableCalendar(
              value: value, calendarFormat: calendarFormat, focusedDay: _focusedDay, onDaySelected: _onDaySelected);
        },
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    _focusedDay = selectedDay;
    if (singleSelect) {
      selectedDays.value.clear();
      selectedDays.value.add(selectedDay);
    } else {
      if (selectedDays.value.contains(selectedDay)) {
        selectedDays.value.remove(selectedDay);
      } else {
        selectedDays.value.add(selectedDay);
      }
    }

    selectedDays.notifyListeners();
    onDaySelected.call(selectedDays.value);
  }
}

TableCalendar _defaultTableCalendar(
    {required List<DateTime>? value,
    required void Function(DateTime, DateTime)? onDaySelected,
    required DateTime focusedDay,
    required CalendarFormat calendarFormat}) {
  return TableCalendar(
    selectedDayPredicate: (day) {
      return value!.contains(day);
    },
    onDaySelected: onDaySelected,
    locale: Platform.localeName.substring(0, 2),
    firstDay: DateTime(DateTime.now().year, DateTime.now().month - 3, DateTime.now().day),
    lastDay: DateTime(DateTime.now().year + 1, DateTime.now().month + 3, DateTime.now().day),
    focusedDay: focusedDay,
    calendarFormat: calendarFormat,
    startingDayOfWeek: StartingDayOfWeek.monday,
    availableGestures: AvailableGestures.none, //disable swipe between days
    availableCalendarFormats: {
      calendarFormat: calendarFormat.name,
    },
    headerStyle: const HeaderStyle(
      titleTextStyle: TextStyle(color: DSColors.gray6, fontSize: 16, fontWeight: FontWeight.w500),
      formatButtonTextStyle: TextStyle(color: DSColors.gray6),
      leftChevronIcon: Icon(
        Icons.chevron_left,
        color: DSColors.gray6,
      ),
      rightChevronIcon: Icon(
        Icons.chevron_right,
        color: DSColors.gray6,
      ),
    ),
    calendarStyle: const CalendarStyle(
      defaultTextStyle: TextStyle(color: DSColors.gray6),
      weekendTextStyle: TextStyle(color: DSColors.tomato),
      outsideTextStyle: TextStyle(color: DSColors.gray3),
    ),
    daysOfWeekStyle: DaysOfWeekStyle(
      dowTextFormatter: (date, locale) {
        return locale == 'ko'
            ? DateFormat.E(locale).format(date).substring(0, 1)
            : DateFormat.E(locale).format(date).substring(0, 2);
      },
      weekdayStyle: const TextStyle(color: DSColors.gray6),
      weekendStyle: const TextStyle(color: DSColors.tomato),
    ),
    headerVisible: true,
    calendarBuilders: CalendarBuilders(
      todayBuilder: (context, day, focusedDay) {
        return dsTodayCell(day);
      },
      selectedBuilder: (context, day, _) {
        return dsSelectedCell(day);
      },
      markerBuilder: (context, day, events) {
        return dsMarker(events.length);
      },
    ),
  );
}

Container dsTodayCell(DateTime day) {
  return Container(
    decoration: BoxDecoration(
      color: DSColors.facebook_blue.withOpacity(0.5),
      shape: BoxShape.circle,
    ),
    margin: const EdgeInsets.all(4.0),
    child: Center(
      child: Text(
        '${day.day}',
        style: const TextStyle(
          fontSize: 16.0,
          color: DSColors.white,
        ),
      ),
    ),
  );
}

Container dsSelectedCell(DateTime day) {
  return Container(
    decoration: BoxDecoration(
      color: DSColors.grapefruit.withOpacity(0.5),
      shape: BoxShape.circle,
    ),
    margin: const EdgeInsets.all(4.0),
    child: Center(
      child: Text(
        '${day.day}',
        style: const TextStyle(
          fontSize: 16.0,
          color: DSColors.white,
        ),
      ),
    ),
  );
}

Widget? dsMarker(int count) {
  late Widget? chiid;
  switch (count) {
    case 1:
      chiid = Text(
        count.toString(),
      );
      break;
    case 2:
      chiid = Text(
        count.toString(),
      );
      break;
    case 3:
      chiid = Text(
        count.toString(),
      );
      break;
    case 4:
      chiid = Text(
        count.toString(),
      );
      break;
    case 5:
      chiid = Text(
        count.toString(),
      );
      break;
    default:
      chiid = null;
      break;
  }
  return chiid != null
      ? AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: CalendarStyle().cellMargin,
          padding: CalendarStyle().cellPadding,
          decoration: CalendarStyle().disabledDecoration,
          alignment: CalendarStyle().cellAlignment,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              width: 30,
              height: 30,
              child: Center(
                child: chiid,
              ),
              color: Colors.amber,
            ),
          ),
        )
      : null;
}
