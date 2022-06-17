import 'dart:convert';

class ModelRequestSignIn {
  String email;
  ModelRequestSignIn({
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
    };
  }

  factory ModelRequestSignIn.fromMap(Map<String, dynamic> map) {
    return ModelRequestSignIn(
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestSignIn.fromJson(String source) => ModelRequestSignIn.fromMap(json.decode(source));
}
