import 'dart:convert';

class ModelRequestGetRecords {
  DateTime startDate;
  DateTime endDate;
  ModelRequestGetRecords({
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }

  factory ModelRequestGetRecords.fromMap(Map<String, dynamic> map) {
    return ModelRequestGetRecords(
      startDate: DateTime.parse(map['startDate']).toLocal(),
      endDate: DateTime.parse(map['endDate']).toLocal(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestGetRecords.fromJson(String source) => ModelRequestGetRecords.fromMap(json.decode(source));
}
