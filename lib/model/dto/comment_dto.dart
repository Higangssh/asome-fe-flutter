class CommentDto {
  final int id;
  final String? profileImage;
  final String nickname;
  final String createDate;
  final String content;
  final int likeCount;
  final int replyCount;
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

  @override
  String toString() {
    return 'CommentDto(id: $id, profileImage: $profileImage, nickname: $nickname, createDate: $createDate, content: $content, likeCount: $likeCount, replyCount: $replyCount, parentId: $parentId, children: $children)';
  }
}