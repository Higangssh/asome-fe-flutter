class GroupDto {
  final int? id;
  final int? hostId;
  final int? total;
  final String? groupName;
  final String? groupLoc;
  String? gender;
  final String? isMatch;

  GroupDto({
    this.id,
    this.hostId,
    this.total,
    this.groupName,
    this.groupLoc,
    this.gender,
    this.isMatch,
  });

  factory GroupDto.fromJson(Map<String, dynamic> json) {
    return GroupDto(
      id: json['id'] as int?,
      hostId: json['hostId'] as int?,
      total: json['total'] as int?,
      groupName: json['groupName'] as String?,
      groupLoc: json['groupLoc'] as String?,
      gender: json['gender'] as String?,
      isMatch: json['isMatch'] as String?,
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