class ChatRoom {
  String roomName;
  String lastMessage;
  DateTime lastMessageTime;

  ChatRoom({
    required this.roomName,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      roomName: json['roomName'],
      lastMessage: json['lastMessage'],
      lastMessageTime: DateTime.parse(json['lastMessageTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomName': roomName,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime.toIso8601String(),
    };
  }
}