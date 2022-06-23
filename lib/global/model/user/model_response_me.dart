import 'dart:convert';

import 'package:my_workout_diary_app/global/model/user/model_user.dart';

class ModelResponseMe {
  bool success;
  String? error;
  List<ModelUser>? data;
  ModelResponseMe({
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

  factory ModelResponseMe.fromMap(Map<String, dynamic> map) {
    return ModelResponseMe(
      success: map['success'],
      error: map['error'],
      data: map['data'] != null ? List<ModelUser>.from(map['data'].map((x) => ModelUser.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseMe.fromJson(String source) => ModelResponseMe.fromMap(json.decode(source));
}
