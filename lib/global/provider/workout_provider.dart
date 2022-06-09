import 'package:my_workout_diary_app/global/enum/countdown_type.dart';
import 'package:my_workout_diary_app/global/enum/item_type.dart';
import 'package:my_workout_diary_app/global/enum/working_type.dart';
import 'package:my_workout_diary_app/global/provider/parent_provider.dart';

class WorkoutProvider extends ParentProvider {
  double _workoutTime = 20;
  double _restTime = 10;
  double _interval = 5;

  CountdownType _countdownType = CountdownType.stopped;
  WorkingType _workingType = WorkingType.ready;

  ItemType _selectedType = ItemType.workout;

  double get workoutTime => _workoutTime;
  double get restTime => _restTime;
  double get interval => _interval;

  ItemType get selectedType => _selectedType;
  WorkingType get workingType => _workingType;
  CountdownType get countdownType => _countdownType;

  void setWorkoutTime(double workoutTime) {
    _workoutTime = workoutTime;
    notifyListeners();
  }

  void setRestTime(double restTime) {
    _restTime = restTime;
    notifyListeners();
  }

  void setInterval(double interval) {
    _interval = interval;
    notifyListeners();
  }

  void setItemType(ItemType item) {
    _selectedType = item;
    notifyListeners();
  }

  void setWorkingType(WorkingType workingType) {
    _workingType = workingType;
    notifyListeners();
  }

  void setCountdownType(CountdownType countdownType) {
    _countdownType = countdownType;
    notifyListeners();
  }
}
