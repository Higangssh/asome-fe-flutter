
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

import '../../controller/chat_room_controller.dart';
import '../bar/custom_appbar.dart';
import '../bar/custom_bottombar.dart';
import 'chat_page.dart';

class ChatRoomListPage extends StatelessWidget {
  final ChatRoomController controller = Get.put(ChatRoomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(themeData: Theme.of(context)),
      bottomNavigationBar: CustomBottomBar(),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.chatRooms.length,
          itemBuilder: (context, index) {
            final chatRoom = controller.chatRooms[index];
            return ListTile(
              title: Text(chatRoom.roomName),
              subtitle: Text(chatRoom.lastMessage),
              trailing: Text(
                DateFormat('HH:mm').format(chatRoom.lastMessageTime),
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                Get.to(() => ChatPage(chatRoom: chatRoom));
              },
            );
          },
        );
      }),
    );
  }
}