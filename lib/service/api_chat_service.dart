import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/url_token_controller.dart';
import '../model/dto/chat_room_dto.dart';

class ApiFormService {
  final UrlTokenController _controller = Get.find<UrlTokenController>();

  get http => null;


  Future<List<ChatRoom>> fetchChatRooms() async {
    final String baseUrl = "${_controller.url.value}/api/group";
    final response = await http.get(Uri.parse('$baseUrl/chatrooms'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => ChatRoom.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load chat rooms');
    }
  }
}