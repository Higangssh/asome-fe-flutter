
import 'dart:convert';
import 'package:asome/controller/url_token_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/dto/chat_list_dto.dart';
class ChatRoomController extends GetxController {
  var chatRooms = <ChatListDto>[].obs;
  final UrlTokenController _controller = Get.find<UrlTokenController>();
  @override
  void onInit() {
    fetchChatRooms();
    super.onInit();
  }

  Future<void> fetchChatRooms() async {
    String baseUrl = "${_controller.url.value}/api/chat/list";
    final response = await http.get(
        Uri.parse(baseUrl)
        ,headers: _controller.createHeaders());

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      chatRooms.value = data.map((chat) => ChatListDto.fromJson(chat)).toList();
    }
  }
}
  