import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../controller/chat_room_controller.dart';
import '../../route/main_route.dart';
import '../bar/custom_bottombar.dart';
import '../bar/custom_chat_appbar.dart';

class ChatRoomListPage extends StatelessWidget {
  final ChatRoomController controller = Get.find<ChatRoomController>();

  ChatRoomListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomChatAppBar(themeData: Theme.of(context)),
      bottomNavigationBar: CustomBottomBar(),
      body: Column(
        children: [
          const Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey,
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.chatRooms.length,
                itemBuilder: (context, index) {
                  final chatRoom = controller.chatRooms[index];
                  return ListTile(
                    leading: FaIcon(FontAwesomeIcons.rocketchat , color:  HexColor("#00E8C1"),), // 아이콘 추가
                    title: Text(chatRoom.chatName ?? 'No Name'),
                    subtitle: Text(chatRoom.content ?? 'No Content'),
                    trailing: Text(
                      _formatDate(chatRoom.lastChatAt),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    onTap: () {
                      Get.toNamed(MainRoute.chatPage, arguments: chatRoom);
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'No Time';
    final date = DateTime.parse(dateString);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return DateFormat('HH:mm').format(date);
    } else if (date.year == now.year) {
      return DateFormat('MM/dd').format(date);
    } else {
      return DateFormat('yyyy/MM/dd').format(date);
    }
  }
}



