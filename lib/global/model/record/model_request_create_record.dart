import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:my_workout_diary_app/global/enum/condition_type.dart';

class ModelRequestCreateRecord {
  int workoutTime;
  //enum
  ConditionType condition;
  DateTime startTime;
  DateTime endTime;
  ModelRequestCreateRecord({
    required this.workoutTime,
    required this.condition,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'workoutTime': workoutTime,
      'condition': EnumToString.convertToString(condition),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    };
  }

  factory ModelRequestCreateRecord.fromMap(Map<String, dynamic> map) {
    return ModelRequestCreateRecord(
      workoutTime: map['workoutTime']?.toInt(),
      condition: EnumToString.fromString(ConditionType.values, map['condition'])!,
      startTime: DateTime.parse(map['startTime']).toLocal(),
      endTime: DateTime.parse(map['endTime']).toLocal(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestCreateRecord.fromJson(String source) => ModelRequestCreateRecord.fromMap(json.decode(source));
}
