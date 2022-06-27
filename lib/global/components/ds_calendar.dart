import 'dart:collection';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:my_workout_diary_app/global/enum/condition_type.dart';
import 'package:my_workout_diary_app/global/model/record/model_record.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

TableCalendar DSTableCalendar(
    {required DateTime? selectedDay,
    required void Function(DateTime, DateTime)? onDaySelected,
    required DateTime focusedDay,
    required List<ModelRecord> Function(DateTime)? eventLoader}) {
  String klocale = Platform.localeName.substring(0, 2) == 'un' ? 'en' : Platform.localeName.substring(0, 2);
  return TableCalendar<ModelRecord>(
    rowHeight: 80,
    daysOfWeekHeight: 40,
    selectedDayPredicate: (day) => isSameDay(selectedDay, day),
    onDaySelected: onDaySelected,
    locale: klocale,
    firstDay: DateTime(2022, 5, 1),
    lastDay: DateTime.now(),
    focusedDay: selectedDay ?? focusedDay,
    calendarFormat: CalendarFormat.month,
    startingDayOfWeek: StartingDayOfWeek.monday,
    availableGestures: AvailableGestures.none, //disable swipe between days
    availableCalendarFormats: {
      CalendarFormat.month: CalendarFormat.month.name,
    },
    eventLoader: eventLoader,
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
      weekdayStyle: const TextStyle(color: DSColors.gray6),
      weekendStyle: const TextStyle(color: DSColors.tomato),
    ),
    headerVisible: true,
    calendarBuilders: CalendarBuilders(
      dowBuilder: (context, day) {
        return Align(
            alignment: Alignment.topCenter,
            child: Text(
              DateFormat.E(klocale).format(day),
              style: _isWeekend(day) ? CalendarStyle().weekendTextStyle : CalendarStyle().defaultTextStyle,
            ));
      },
      prioritizedBuilder: (context, day, focusedDay) {
        return _cell(day, focusedDay, selectedDay);
      },
      markerBuilder: (context, day, events) {
        return _dsMarker(events);
      },
    ),
  );
}

Widget _cell(DateTime day, DateTime focusDay, DateTime? selectedDay) {
  //todayBuilder
  if (isSameDay(day, DateTime.now())) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      alignment: Alignment.topCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
            width: 25,
            child: ColoredBox(
                color: DSColors.grapefruit.withOpacity(0.5),
                child: Text(
                  day.day.toString(),
                  textAlign: TextAlign.center,
                ))),
      ),
    );
  }
  //selectedBuilder
  if (isSameDay(day, selectedDay)) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      alignment: Alignment.topCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
            width: 25,
            child: ColoredBox(
                color: DSColors.facebook_blue.withOpacity(0.7),
                child: Text(
                  day.day.toString(),
                  textAlign: TextAlign.center,
                ))),
      ),
    );
  }
  return AnimatedContainer(
    duration: const Duration(milliseconds: 250),
    alignment: Alignment.topCenter,
    child: Text(day.day.toString(),
        style: _isOutside(day, focusDay) ? CalendarStyle().outsideTextStyle : CalendarStyle().defaultTextStyle),
  );
}

Widget _dsMarker(List<ModelRecord>? records) {
  late Widget? chiid;
  int today = 0;

  if (records != null && records.length >= 1) {
    int sum = 0;
    records.forEach((element) {
      sum += _conditionTypeParse(element.condition);
      print(element.condition);
    });
    today = sum ~/ records.length;
  } else {}
  switch ((today)) {
    case 1:
      chiid = Image.asset('assets/images/b1.png');
      break;
    case 2:
      chiid = Image.asset('assets/images/b2.png');
      break;
    case 3:
      chiid = Image.asset('assets/images/b3.png');
      break;
    case 4:
      chiid = Image.asset('assets/images/b4.png');
      break;
    case 5:
      chiid = Image.asset('assets/images/b5.png');
      break;
    default:
      chiid = Image.asset('assets/images/default_marker.png');
      break;
  }
  return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: CalendarStyle().cellMargin,
      padding: CalendarStyle().cellPadding,
      alignment: CalendarStyle().cellAlignment,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          maxRadius: 25.0,
          child: chiid,
        ),
      ));
}

_isOutside(DateTime day, DateTime focusDay) => day.month != focusDay.month;
bool _isWeekend(
  DateTime day, {
  List<int> weekendDays = const [DateTime.saturday, DateTime.sunday],
}) {
  return weekendDays.contains(day.weekday);
}

int _conditionTypeParse(ConditionType type) {
  //GT, VG, GD, NB, BD
  switch (type) {
    case ConditionType.GT:
      return 5;
    case ConditionType.VG:
      return 4;
    case ConditionType.GD:
      return 3;
    case ConditionType.NB:
      return 2;
    case ConditionType.BD:
    default:
      return 1;
  }
}
