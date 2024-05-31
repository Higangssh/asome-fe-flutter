import 'package:get/get.dart';
import '../model/dto/chatroomdto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatRoomController extends GetxController {
  var chatRooms = <ChatRoom>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchChatRooms();
  }

  void fetchChatRooms() async {
    final response = await http.get(Uri.parse('http://example.com/api/chatrooms'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      chatRooms.value = data.map((item) => ChatRoom.fromJson(item)).toList();
      sortChatRooms();
    } else {
      // 오류 처리
    }
  }

  void updateLastMessage(String roomName, String lastMessage) async {
    ChatRoom? chatRoom = chatRooms.firstWhereOrNull((room) => room.roomName == roomName);
    if (chatRoom != null) {
      final response = await http.post(
        Uri.parse('http://example.com/api/chatrooms/$roomName/messages'),
        body: jsonEncode({'message': lastMessage}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        chatRoom.lastMessage = lastMessage;
        chatRoom.lastMessageTime = DateTime.now();
        sortChatRooms();
        chatRooms.refresh();
      } else {
        // 오류 처리
      }
    }
  }

  void sortChatRooms() {
    chatRooms.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
  }
}
