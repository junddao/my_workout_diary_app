import 'dart:convert';

class ModelRequestGetToken {
  String email;
  ModelRequestGetToken({
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
    };
  }

  factory ModelRequestGetToken.fromMap(Map<String, dynamic> map) {
    return ModelRequestGetToken(
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestGetToken.fromJson(String source) => ModelRequestGetToken.fromMap(json.decode(source));
}
