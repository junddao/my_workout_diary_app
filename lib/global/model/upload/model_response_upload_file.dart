import 'dart:convert';

class ModelResponseUploadFile {
  bool success;
  String? error;
  List<String> data;
  ModelResponseUploadFile({
    required this.success,
    this.error,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'error': error,
      'data': data,
    };
  }

  factory ModelResponseUploadFile.fromMap(Map<String, dynamic> map) {
    return ModelResponseUploadFile(
      success: map['success'],
      error: map['error'] != null ? map['error'] : null,
      data: List<String>.from(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseUploadFile.fromJson(String source) => ModelResponseUploadFile.fromMap(json.decode(source));
}
