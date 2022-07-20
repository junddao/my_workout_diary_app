import 'dart:convert';

class ModelRequestSignUp {
  String uid;
  String social;
  String email;
  String name;
  String password;
  String? profileImage;
  ModelRequestSignUp({
    required this.uid,
    required this.social,
    required this.email,
    required this.name,
    required this.password,
    this.profileImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'social': social,
      'email': email,
      'name': name,
      'password': password,
      'profileImage': profileImage,
    };
  }

  factory ModelRequestSignUp.fromMap(Map<String, dynamic> map) {
    return ModelRequestSignUp(
      uid: map['uid'],
      social: map['social'],
      email: map['email'],
      name: map['name'],
      password: map['password'],
      profileImage: map['profileImage'] != null ? map['profileImage'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestSignUp.fromJson(String source) => ModelRequestSignUp.fromMap(json.decode(source));
}
