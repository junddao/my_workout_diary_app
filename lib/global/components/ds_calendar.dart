import 'dart:collection';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:my_workout_diary_app/global/model/record/model_record.dart';
import 'package:my_workout_diary_app/global/model/record/model_record_event.dart';
import 'package:my_workout_diary_app/global/style/ds_colors.dart';
import 'package:my_workout_diary_app/pages/02_record/page_record.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

TableCalendar DSTableCalendar(
    {required DateTime? selectedDay,
    required void Function(DateTime, DateTime)? onDaySelected,
    required DateTime focusedDay,
    required List<ModelRecord> Function(DateTime)? eventLoader}) {
  return TableCalendar<ModelRecord>(
    selectedDayPredicate: (day) => isSameDay(selectedDay, day),
    onDaySelected: onDaySelected,
    locale: Platform.localeName.substring(0, 2) == 'un' ? 'ko' : Platform.localeName.substring(0, 2),
    firstDay: DateTime(2022, 5, 1),
    lastDay: DateTime.now(),
    focusedDay: focusedDay,
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
