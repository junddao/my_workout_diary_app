import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';

import 'package:my_workout_diary_app/global/enum/condition_type.dart';
import 'package:my_workout_diary_app/global/model/record/model_record.dart';

class ModelResponseGetRecords {
  bool success;
  String? error;
  List<ModelRecord>? data;
  ModelResponseGetRecords({
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

  factory ModelResponseGetRecords.fromMap(Map<String, dynamic> map) {
    return ModelResponseGetRecords(
      success: map['success'],
      error: map['error'] != null ? map['error'] : null,
      data: map['data'] != null ? List<ModelRecord>.from(map['data'].map((x) => ModelRecord.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseGetRecords.fromJson(String source) => ModelResponseGetRecords.fromMap(json.decode(source));
}
