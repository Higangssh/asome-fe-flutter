class PostRequestDto {
  final int commonId;
  final String title;
  final String content;

  PostRequestDto({required this.commonId, required this.title, required this.content});

  Map<String, dynamic> toJson() {
    return {
      'commonId': commonId,
      'title': title,
      'content': content,
    };
  }
}