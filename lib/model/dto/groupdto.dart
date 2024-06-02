import 'dart:ffi';

import 'memberdto.dart';

class GroupDto {
  final int? id;
  final int? hostId;
  final int? total;
  final String? groupName;
  final String? groupLoc;
  String? gender;
  final String? isMatch;
  final List<MemberDto>? members;

  GroupDto({
    this.id,
    this.hostId,
    this.total,
    this.groupName,
    this.groupLoc,
    this.gender,
    this.isMatch,
    this.members
  });

  factory GroupDto.fromJson(Map<String, dynamic> json) {
    var membersJson = json['members'] as List<dynamic>?;
    List<MemberDto> memberList = membersJson != null
        ? membersJson.map((i) => MemberDto.fromJson(i)).toList()
        : [];
    return GroupDto(
      id: json['id'] as int?,
      hostId: json['hostId'] as int?,
      total: json['total'] as int?,
      groupName: json['groupName'] as String?,
      groupLoc: json['groupLoc'] as String?,
      gender: json['gender'] == 'M' ? '남자' : '여자' as String?,
      isMatch: json['isMatch'] as String?,
      members: memberList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hostId': hostId,
      'total': total,
      'groupName': groupName,
      'groupLoc': groupLoc,
      'gender': gender,
      'isMatch': isMatch,
    };
  }
}