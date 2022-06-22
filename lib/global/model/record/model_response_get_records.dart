import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';

import 'package:my_workout_diary_app/global/enum/condition_type.dart';
import 'package:my_workout_diary_app/global/model/record/model_record.dart';

class ModelResponseGetRecords {
  List<ModelRecord> records;
  ModelResponseGetRecords({
    required this.records,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'records': records.map((x) => x.toMap()).toList(),
    };
  }

  factory ModelResponseGetRecords.fromMap(Map<String, dynamic> map) {
    return ModelResponseGetRecords(
      records: List<ModelRecord>.from(map['records'].map((x) => ModelRecord.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseGetRecords.fromJson(String source) => ModelResponseGetRecords.fromMap(json.decode(source));
}
