import 'package:flutter/material.dart';
import 'package:my_workout_diary_app/global/enum/view_state.dart';

class ParentProvider with ChangeNotifier {
  ViewState _state = ViewState.Idle;
  ViewState get state => _state;

  void initialize() async {
    _state = ViewState.Busy;
  }

  void uninitialize() async {
    _state = ViewState.Idle;
  }

  setStateBusy() {
    _state = ViewState.Busy;
    notifyListeners();
  }

  setStateIdle() {
    _state = ViewState.Idle;
    notifyListeners();
  }

  setStateError() {
    _state = ViewState.Error;
    notifyListeners();
  }
}
