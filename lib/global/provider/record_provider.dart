import 'dart:async';
import 'dart:collection';

import 'package:intl/intl.dart';
import 'package:my_workout_diary_app/global/bloc/parent_provider.dart';
import 'package:my_workout_diary_app/global/model/record/model_record.dart';
import 'package:my_workout_diary_app/global/model/record/model_record_event.dart';
import 'package:my_workout_diary_app/global/model/record/model_request_get_records.dart';
import 'package:my_workout_diary_app/global/model/record/model_response_get_records.dart';
import 'package:my_workout_diary_app/global/service/api_service.dart';
import 'package:my_workout_diary_app/global/util/extension/datetime.dart';
import 'package:table_calendar/table_calendar.dart';

class RecordProvider extends ParentProvider {
  late Timer _timer;

  double _time = 0;
  bool _isStart = false;

  double get time => _time;
  bool get isStart => _isStart;

  List<ModelRecord> records = [];

  void start() {
    _isStart = true;
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) async {
      _time++;
      print(_time);
      notifyListeners();
    });
  }

  // 타이머 취소
  void pause() {
    _timer.cancel();
    notifyListeners();
  }

  void stop() {
    _isStart = false;
    _timer.cancel();
    _time = 0;
    notifyListeners();
  }

  Future<bool> getRecords(ModelRequestGetRecords requestGetRecords) async {
    try {
      setStateBusy();
      const String path = '/record/get/records';

      var response = await ApiService().post(path, requestGetRecords.toMap());
      ModelResponseGetRecords modelResponseGetRecords = ModelResponseGetRecords.fromMap(response);

      records = modelResponseGetRecords.data ?? [];
      setStateIdle();
      return true;
    } catch (e) {
      return false;
    }
  }

  LinkedHashMap<DateTime, List<ModelRecord>> getEvents() {
    final kToday = DateTime.now();

    List<DateTime> eventDates = [];
    String tmpDate = '';

    records.forEach((element) {
      String startDateStr = DateFormat('yyyy-MM-dd').format(element.startTime);
      if (tmpDate != startDateStr) {
        eventDates.add(element.startTime);

        tmpDate = startDateStr;
      }
    });

    Map<DateTime, List<ModelRecord>> map = {
      for (var i in List.generate(eventDates.length, (index) => index))
        eventDates[i]: List.generate(
          records
              .where((element) {
                bool result = element.startTime.toFullDateString3() == eventDates[i].toFullDateString3();
                return result;
              })
              .toList()
              .length,
          (index) {
            print(index);
            List<ModelRecord> filteredRecords = [];
            for (var e in records) {
              if (e.startTime.toFullDateString3() == eventDates[i].toFullDateString3()) {
                filteredRecords.add(e);
              }
            }
            return filteredRecords[index];
          },
        )
    };

    final result = LinkedHashMap<DateTime, List<ModelRecord>>(
      equals: isSameDay,
      hashCode: (DateTime key) {
        return key.day * 1000000 + key.month * 10000 + key.year;
      },
    )..addAll(map);

    return result;
  }
}
