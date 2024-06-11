
import 'dart:ffi';

class MemberDto {
  int? id;
  String? email;
  String? nick;
  DateTime? birth;
  String? universityEmail;
  String? universityName;
  String? gender;  // 추가된 필드
  String? createAt;
  String? modifiedAt;

  MemberDto({
    this.id,
    this.email,
    this.nick,
    this.birth,
    this.universityEmail,
    this.universityName,
    this.gender,  // 추가된 필드
    this.createAt,
    this.modifiedAt,
  });

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'nick': nick,
      'birth': birth?.toIso8601String(),
      'universityEmail': universityEmail,
      'universityName': universityName,
      'gender': gender,  // 추가된 필드
      'createAt': createAt,
      'modifiedAt': modifiedAt,
    };
  }

  // JSON deserialization
  factory MemberDto.fromJson(Map<String, dynamic> json) {
    return MemberDto(
      id: json['id'] as int?,
      email: json['email'] as String?,
      nick: json['nick'] as String?,
      birth: json['birth'] != null ? DateTime.parse(json['birth']) : null,
      universityEmail: json['universityEmail'] as String?,
      universityName: json['universityName'] as String?,
      gender: json['gender'] == 'M' ? '남자' : '여자' as String?,  // 추가된 필드
      createAt: json['createAt'] as String?,
      modifiedAt: json['modifiedAt'] as String?,
    );
  }

}
