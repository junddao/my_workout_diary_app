import 'dart:convert';

class ModelRequestSignIn {
  String fbUid;
  ModelRequestSignIn({
    required this.fbUid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fbUid': fbUid,
    };
  }

  factory ModelRequestSignIn.fromMap(Map<String, dynamic> map) {
    return ModelRequestSignIn(
      fbUid: map['fbUid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestSignIn.fromJson(String source) => ModelRequestSignIn.fromMap(json.decode(source));
}
