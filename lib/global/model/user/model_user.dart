import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';

import 'package:my_workout_diary_app/global/enum/socail_type.dart';

class ModelUser {
  String? id;
  String? email;
  String? name;
  String? introduce;
  String? profileImage;

  String? social;
  bool? pushEnabled;
  String? createdAt;
  String? updatedAt;
  //  String smsEnabled
  //  String agreeTerms
  //  String phoneNumber

  ModelUser({
    this.id,
    this.email,
    this.name,
    this.introduce,
    this.profileImage,
    this.social,
    this.pushEnabled,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'email': email,
      'name': name,
      'introduce': introduce,
      'profileImage': profileImage,
      'social': social,
      'pushEnabled': pushEnabled,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ModelUser.fromMap(Map<String, dynamic> map) {
    return ModelUser(
      id: map['_id'],
      email: map['email'],
      name: map['name'],
      introduce: map['introduce'],
      profileImage: map['profileImage'],
      social: map['social'],
      pushEnabled: map['pushEnabled'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelUser.fromJson(String source) => ModelUser.fromMap(json.decode(source));
}
