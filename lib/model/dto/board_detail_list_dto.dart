class BoardDetailsDto {
  final int postId;
  final String nick;
  final String title;
  final String content;
  final String createDate;
  int commentCount;
  int likeCount;
  bool isLiked;
  int viewCount;

  BoardDetailsDto({
    required this.postId,
    required this.nick,
    required this.title,
    required this.content,
    required this.createDate,
    required this.commentCount,
    required this.likeCount,
    required this.isLiked,
    required this.viewCount,
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
      viewCount: json['viewCount']
    );
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


  String get relativeTime {
    return timeAgoSinceDate(createDate);
  }
}
