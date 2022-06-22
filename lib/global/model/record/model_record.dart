import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:my_workout_diary_app/global/enum/condition_type.dart';

class ModelRecord {
  String id;
  DateTime workoutTime;
  //enum
  ConditionType condition;
  DateTime startTime;
  DateTime endTime;
  DateTime createdAt;
  DateTime updatedAt;
  ModelRecord({
    required this.id,
    required this.workoutTime,
    required this.condition,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'workoutTime': workoutTime.toIso8601String(),
      'condition': EnumToString.convertToString(condition),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory ModelRecord.fromMap(Map<String, dynamic> map) {
    return ModelRecord(
      id: map['id'],
      workoutTime: DateTime.parse(map['workoutTime']).toLocal(),
      condition: EnumToString.fromString(ConditionType.values, map['condition'])!,
      startTime: DateTime.parse(map['startTime']).toLocal(),
      endTime: DateTime.parse(map['endTime']).toLocal(),
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
      updatedAt: DateTime.parse(map['updatedAt']).toLocal(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRecord.fromJson(String source) => ModelRecord.fromMap(json.decode(source));
}
