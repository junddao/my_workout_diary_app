import 'dart:convert';

import 'package:my_workout_diary_app/global/model/user/model_user.dart';

class ModelResponseUpdate {
  bool success;
  String? error;
  List<ModelUser>? data;
  ModelResponseUpdate({
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

  factory ModelResponseUpdate.fromMap(Map<String, dynamic> map) {
    return ModelResponseUpdate(
      success: map['success'],
      error: map['error'],
      data: map['data'] != null ? List<ModelUser>.from(map['data'].map((x) => ModelUser.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseUpdate.fromJson(String source) => ModelResponseUpdate.fromMap(json.decode(source));
}
