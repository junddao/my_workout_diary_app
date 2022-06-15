import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';

import 'package:my_workout_diary_app/global/enum/socail_type.dart';

class ModelUser {
  String email;
  String nickname;
  String? introduce;
  String? profileImage;

  String socialType;
  //  String status (signed, active, left)
  //  String pushEnabled
  //  String smsEnabled
  //  String agreeTerms
  //  String phoneNumber
  DateTime? createdAt;
  DateTime? updatedAt;
  ModelUser({
    required this.email,
    required this.nickname,
    this.introduce,
    this.profileImage,
    required this.socialType,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'nickname': nickname,
      'introduce': introduce,
      'profileImage': profileImage,
      'socialType': socialType,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory ModelUser.fromMap(Map<String, dynamic> map) {
    return ModelUser(
      email: map['email'],
      nickname: map['nickname'],
      introduce: map['introduce'] != null ? map['introduce'] : null,
      profileImage: map['profileImage'] != null ? map['profileImage'] : null,
      socialType: map['socialType'],
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']).toLocal() : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']).toLocal() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelUser.fromJson(String source) => ModelUser.fromMap(json.decode(source));
}
