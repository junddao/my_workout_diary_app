import 'dart:async';

import 'package:my_workout_diary_app/global/bloc/parent_provider.dart';
import 'package:my_workout_diary_app/global/model/record/model_record.dart';
import 'package:my_workout_diary_app/global/model/record/model_request_get_records.dart';
import 'package:my_workout_diary_app/global/model/record/model_response_get_records.dart';
import 'package:my_workout_diary_app/global/service/api_service.dart';

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
      records = modelResponseGetRecords.records;
      setStateIdle();
      return true;
    } catch (e) {
      return false;
    }
  }
}
