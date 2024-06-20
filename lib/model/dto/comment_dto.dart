class CommentDto {
  final int id;
  final String? profileImage;
  final String nickname;
  final String createDate;
  final String content;
  final int likeCount;
  int replyCount;
  final int? parentId;
  final List<CommentDto> children;

  CommentDto({
    required this.id,
    this.profileImage,
    required this.nickname,
    required this.createDate,
    required this.content,
    required this.likeCount,
    required this.replyCount,
    this.parentId,
    this.children = const [],
  });

  factory CommentDto.fromJson(Map<String, dynamic> json) {
    return CommentDto(
      id: json['id'],
      profileImage: json['profileImage'],
      nickname: json['nick'],
      createDate: json['createDate'],
      content: json['content'],
      likeCount: json['likeCount'] ?? 0,
      replyCount: json['replyCount'] ?? 0,
      parentId: json['parentId'],
      children: json['children'] != null
          ? (json['children'] as List).map((child) =>
          CommentDto.fromJson(child)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profileImage': profileImage,
      'nickname': nickname,
      'createDate': createDate,
      'content': content,
      'likeCount': likeCount,
      'replyCount': replyCount,
      'parentId': parentId,
      'children': children.map((child) => child.toJson()).toList(),
    };
  }

  String timeAgoSinceDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    Duration diff = DateTime.now().difference(date);

    if (diff.inDays > 365) {
      int years = (diff.inDays / 365).floor();
      return "$years년 전";
    } else if (diff.inDays > 30) {
      int months = (diff.inDays / 30).floor();
      return "$months달 전";
    } else if (diff.inDays > 0) {
      return "${diff.inDays}일 전";
    } else if (diff.inHours > 0) {
      return "${diff.inHours}시간 전";
    } else if (diff.inMinutes > 0) {
      return "${diff.inMinutes}분 전";
    } else {
      return "방금 전";
    }
  }

  @override
  String toString() {
    return 'CommentDto(id: $id, profileImage: $profileImage, nickname: $nickname, createDate: $createDate, content: $content, likeCount: $likeCount, replyCount: $replyCount, parentId: $parentId, children: $children)';
  }
}