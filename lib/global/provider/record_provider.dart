import 'dart:async';
import 'dart:collection';

import 'package:intl/intl.dart';
import 'package:my_workout_diary_app/global/bloc/parent_provider.dart';
import 'package:my_workout_diary_app/global/model/common/model_response_common.dart';
import 'package:my_workout_diary_app/global/model/record/model_record.dart';
import 'package:my_workout_diary_app/global/model/record/model_record_event.dart';
import 'package:my_workout_diary_app/global/model/record/model_request_create_record.dart';
import 'package:my_workout_diary_app/global/model/record/model_request_get_rankers.dart';
import 'package:my_workout_diary_app/global/model/record/model_request_get_records.dart';
import 'package:my_workout_diary_app/global/model/record/model_response_get_rankers.dart';
import 'package:my_workout_diary_app/global/model/record/model_response_get_records.dart';
import 'package:my_workout_diary_app/global/service/api_service.dart';
import 'package:my_workout_diary_app/global/util/extension/datetime.dart';
import 'package:table_calendar/table_calendar.dart';

class RecordProvider extends ParentProvider {
  late Timer _timer;

  double _time = 0;
  double _recordTime = 0;
  bool _isStart = false;

  double get time => _time;
  double get recordTime => _recordTime;
  bool get isStart => _isStart;

  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now();
  DateTime _passedTime = DateTime.now();

  DateTime get startTime => _startTime;
  DateTime get endTime => _endTime;
  DateTime get passedTime => _passedTime;

  LinkedHashMap<DateTime, List<ModelRecord>>? _kEvents;
  List<ModelRecord> _selectedEvents = [];
  DateTime? _selectedDay = DateTime.now();

  LinkedHashMap<DateTime, List<ModelRecord>>? get kEvents => _kEvents;
  List<ModelRecord> get selectedEvents => _selectedEvents;
  DateTime? get selectedDay => _selectedDay;

  List<ModelRecord> records = [];
  List<ModelRankers> rankers = [];

  void start() {
    _isStart = true;
    _startTime = DateTime.now();
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) async {
      _time++;

      notifyListeners();
    });
  }

  // 타이머 취소
  void pause() {
    _timer.cancel();
    notifyListeners();
  }

  void stop() {
    _endTime = DateTime.now();
    _isStart = false;
    _recordTime = _time;
    _timer.cancel();
    _time = 0;
    notifyListeners();
  }

  void setPassedTime() {
    _passedTime = DateTime.now();
    _time = passedTime.difference(startTime).inSeconds.toDouble() * 10;
    notifyListeners();
  }

  void setSelectedDay(DateTime? selectedDay) {
    _selectedDay = selectedDay;
    notifyListeners();
  }

  void setSelectedEvents() {
    _selectedEvents = kEvents![selectedDay] ?? [];
    notifyListeners();
  }

  void getEvents() {
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

    _kEvents = result;
    notifyListeners();
  }

  Future<bool> createRecord(ModelRequestCreateRecord input) async {
    try {
      setStateBusy();
      const String path = '/record/create';

      var response = await ApiService().post(path, input.toMap());
      ModelResponseCommon modelResponseCommon = ModelResponseCommon.fromMap(response);

      setStateIdle();
      return true;
    } catch (e) {
      return false;
    }
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

  Future<bool> deleteRecord(String id) async {
    try {
      setStateBusy();
      String path = '/record/delete/$id';

      var response = await ApiService().delete(path);
      ModelResponseCommon modelResponseCommon = ModelResponseCommon.fromMap(response);
      setStateIdle();
      if (modelResponseCommon.success == false) return false;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getTopRankers(ModelRequestGetRankers input) async {
    try {
      setStateBusy();
      String path = '/record/get/rankers';

      var response = await ApiService().post(path, input.toMap());
      ModelResponseGetRankers modelResponseGetRankers = ModelResponseGetRankers.fromMap(response);
      rankers = modelResponseGetRankers.data ?? [];
      setStateIdle();

      return true;
    } catch (e) {
      return false;
    }
  }
}
