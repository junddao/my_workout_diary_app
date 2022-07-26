import 'dart:convert';

class ModelResponseGetToken {
  bool success;
  String? error;
  List<ModelGetToken>? data;
  ModelResponseGetToken({
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

  factory ModelResponseGetToken.fromMap(Map<String, dynamic> map) {
    return ModelResponseGetToken(
      success: map['success'],
      error: map['error'],
      data: map['data'] != null ? List<ModelGetToken>.from(map['data'].map((x) => ModelGetToken.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseGetToken.fromJson(String source) => ModelResponseGetToken.fromMap(json.decode(source));
}

class ModelGetToken {
  String accessToken;
  ModelGetToken({
    required this.accessToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
    };
  }

  factory ModelGetToken.fromMap(Map<String, dynamic> map) {
    return ModelGetToken(
      accessToken: map['accessToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelGetToken.fromJson(String source) => ModelGetToken.fromMap(json.decode(source));
}
