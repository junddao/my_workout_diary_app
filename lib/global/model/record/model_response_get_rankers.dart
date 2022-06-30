import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';

import 'package:my_workout_diary_app/global/enum/condition_type.dart';
import 'package:my_workout_diary_app/global/model/record/model_record.dart';

class ModelResponseGetRankers {
  bool success;
  String? error;
  List<ModelRankers>? data;
  ModelResponseGetRankers({
    required this.success,
    this.error,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'error': error,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory ModelResponseGetRankers.fromMap(Map<String, dynamic> map) {
    return ModelResponseGetRankers(
      success: map['success'],
      error: map['error'] != null ? map['error'] : null,
      data: map['data'] != null ? List<ModelRankers>.from(map['data'].map((x) => ModelRankers.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseGetRankers.fromJson(String source) => ModelResponseGetRankers.fromMap(json.decode(source));
}

class ModelRankers {
  String userId;
  String userName;
  String? profileImage;
  int totalWorkoutTime;
  List<DateTime> workoutDates = [];
  int ranking;
  ModelRankers({
    required this.userId,
    required this.userName,
    this.profileImage,
    required this.totalWorkoutTime,
    required this.workoutDates,
    required this.ranking,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'profileImage': profileImage,
      'totalWorkoutTime': totalWorkoutTime,
      'workoutDates': workoutDates.map((x) => x.toIso8601String()).toList(),
      'ranking': ranking,
    };
  }

  factory ModelRankers.fromMap(Map<String, dynamic> map) {
    return ModelRankers(
      userId: map['userId'],
      userName: map['userName'],
      profileImage: map['profileImage'] != null ? map['profileImage'] : null,
      totalWorkoutTime: map['totalWorkoutTime']?.toInt(),
      workoutDates: List<DateTime>.from(map['workoutDates'].map((x) => DateTime.parse(x).toLocal())),
      ranking: map['ranking']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRankers.fromJson(String source) => ModelRankers.fromMap(json.decode(source));
}
