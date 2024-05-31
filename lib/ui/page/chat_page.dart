import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/chat_room_controller.dart';
import '../../model/dto/chatroomdto.dart';

class ChatPage extends StatelessWidget {
  final ChatRoom chatRoom;

  ChatPage({required this.chatRoom});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chatRoom.roomName),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text('Welcome to ${chatRoom.roomName}'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      final chatRoomController = Get.find<ChatRoomController>();
                      chatRoomController.updateLastMessage(chatRoom.roomName, _controller.text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}