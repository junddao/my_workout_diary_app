import 'dart:convert';

class ModelRequestSignIn {
  String email;
  String password;
  ModelRequestSignIn({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory ModelRequestSignIn.fromMap(Map<String, dynamic> map) {
    return ModelRequestSignIn(
      email: map['email'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestSignIn.fromJson(String source) => ModelRequestSignIn.fromMap(json.decode(source));
}
