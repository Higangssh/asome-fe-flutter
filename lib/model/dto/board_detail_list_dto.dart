class BoardDetailsDto {
  final int postId;
  final String nick;
  final String title;
  final String content;
  final String createDate;
  int commentCount;
  int likeCount;
  bool isLiked;

  BoardDetailsDto({
    required this.postId,
    required this.nick,
    required this.title,
    required this.content,
    required this.createDate,
    required this.commentCount,
    required this.likeCount,
    required this.isLiked,
  });

  factory BoardDetailsDto.fromJson(Map<String, dynamic> json) {
    return BoardDetailsDto(
      postId: json['postId'],
      nick: json['nick'],
      title: json['title'],
      content: json['content'],
      createDate: json['createDate'],
      commentCount: json['commentCount'],
      likeCount: json['likeCount'],
      isLiked: json['isLiked'],
    );
  }

}
