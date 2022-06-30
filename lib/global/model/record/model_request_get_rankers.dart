import 'dart:convert';

class ModelRequestGetRankers {
  DateTime startDate;
  DateTime endDate;
  ModelRequestGetRankers({
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }

  factory ModelRequestGetRankers.fromMap(Map<String, dynamic> map) {
    return ModelRequestGetRankers(
      startDate: DateTime.parse(map['startDate']).toLocal(),
      endDate: DateTime.parse(map['endDate']).toLocal(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestGetRankers.fromJson(String source) => ModelRequestGetRankers.fromMap(json.decode(source));
}
