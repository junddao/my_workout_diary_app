import 'dart:convert';

class ModelRequestUpdate {
  String? id;
  String? email;
  String? name;
  String? introduce;
  String? profileImage;

  String? social;
  bool? pushEnabled;
  ModelRequestUpdate({
    this.id,
    this.email,
    this.name,
    this.introduce,
    this.profileImage,
    this.social,
    this.pushEnabled,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'introduce': introduce,
      'profileImage': profileImage,
      'social': social,
      'pushEnabled': pushEnabled,
    };
  }

  factory ModelRequestUpdate.fromMap(Map<String, dynamic> map) {
    return ModelRequestUpdate(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      introduce: map['introduce'],
      profileImage: map['profileImage'],
      social: map['social'],
      pushEnabled: map['pushEnabled'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestUpdate.fromJson(String source) => ModelRequestUpdate.fromMap(json.decode(source));
}
