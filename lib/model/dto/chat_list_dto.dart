class ChatListDto {
  int? chatId;
  String? chatName;
  String? content;
  String? chatType; // Rtype을 String으로 변경
  int? count;
  String? lastChatAt;

  ChatListDto({
    this.chatId,
    this.chatName,
    this.content,
    this.chatType,
    this.count,
    this.lastChatAt,
  });

  // JSON 직렬화 및 역직렬화를 위한 factory 생성자 및 메서드
  factory ChatListDto.fromJson(Map<String, dynamic> json) {
    return ChatListDto(
      chatId: json['chatId'],
      chatName: json['chatName'],
      content: json['content'],
      chatType: json['chatType'],
      count: json['count'],
      lastChatAt: json['lastChatAt'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'chatName': chatName,
      'content': content,
      'chatType': chatType,
      'count': count,
      'lastChatAt': lastChatAt,
    };
  }
}
