import 'dart:async';

class TimerService {
  static final TimerService _instance = TimerService._internal();

  factory TimerService() => _instance;

  TimerService._internal() {
    _time = 0;
  }

  int get time => _time;

  late Timer _timer;
  late int _time;
  bool isRunning = false;

  void start() {
    isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      _time++;
    });
  }

  // 타이머 취소
  void pause() {
    _timer.cancel();
  }

  void stop() {
    isRunning = false;
    _timer.cancel();
    _time = 0;
  }
}
