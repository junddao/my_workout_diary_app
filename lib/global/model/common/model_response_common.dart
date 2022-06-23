import 'dart:convert';

class ModelResponseCommon {
  bool success;
  String? error;
  ModelResponseCommon({
    required this.success,
    this.error,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'error': error,
    };
  }

  factory ModelResponseCommon.fromMap(Map<String, dynamic> map) {
    return ModelResponseCommon(
      success: map['success'],
      error: map['error'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseCommon.fromJson(String source) => ModelResponseCommon.fromMap(json.decode(source));
}
