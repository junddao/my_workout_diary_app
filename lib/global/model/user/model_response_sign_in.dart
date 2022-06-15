import 'dart:convert';

class ModelResponseSignIn {
  String accessToken;
  ModelResponseSignIn({
    required this.accessToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
    };
  }

  factory ModelResponseSignIn.fromMap(Map<String, dynamic> map) {
    return ModelResponseSignIn(
      accessToken: map['accessToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseSignIn.fromJson(String source) => ModelResponseSignIn.fromMap(json.decode(source));
}
