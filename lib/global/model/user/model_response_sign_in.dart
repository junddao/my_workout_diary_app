import 'dart:convert';

class ModelResponseSignIn {
  bool success;
  String? error;
  List<ModelSignIn>? data;
  ModelResponseSignIn({
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

  factory ModelResponseSignIn.fromMap(Map<String, dynamic> map) {
    return ModelResponseSignIn(
      success: map['success'],
      error: map['error'],
      data: map['data'] != null ? List<ModelSignIn>.from(map['data'].map((x) => ModelSignIn.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseSignIn.fromJson(String source) => ModelResponseSignIn.fromMap(json.decode(source));
}

class ModelSignIn {
  String accessToken;
  ModelSignIn({
    required this.accessToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
    };
  }

  factory ModelSignIn.fromMap(Map<String, dynamic> map) {
    return ModelSignIn(
      accessToken: map['accessToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelSignIn.fromJson(String source) => ModelSignIn.fromMap(json.decode(source));
}
