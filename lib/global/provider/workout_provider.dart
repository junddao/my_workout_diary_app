import 'dart:async';

import 'package:my_workout_diary_app/global/bloc/parent_provider.dart';

class WorkoutProvider extends ParentProvider {
  late Timer _timer;

  double _time = 0;
  bool _isStart = false;

  double get time => _time;
  bool get isStart => _isStart;

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
}
