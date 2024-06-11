class MessageDto {
  final int id;
  final String content;
  final String? createAt;
  final String? nick;

  MessageDto({
    required this.id,
    required this.content,
    required this.createAt,
    required this.nick,
  });

  factory MessageDto.fromJson(Map<String, dynamic> json) {
    return MessageDto(
      id: json['id'],
      content: json['content'],
      createAt: json['createAt'],
      nick: json['nick'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'createAt': createAt,
      'nick': nick,
    };
  }
}
