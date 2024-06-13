
import 'dart:convert';
import 'package:asome/controller/url_token_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/dto/chat_list_dto.dart';
import '../service/api_initial_service.dart';
class ChatRoomController extends GetxController {
  var chatRooms = <ChatListDto>[].obs;
  final UrlTokenController _controller = Get.find<UrlTokenController>();
  late final ApiInitialService apiInitialService;
  @override
  void onInit() {
    apiInitialService = ApiInitialService(_controller);
    fetchChatRooms();
    super.onInit();
  }

  Future<void> fetchChatRooms() async {
    String baseUrl = "${_controller.url.value}/api/chat/list";
    var headers = _controller.createHeaders();
    final response = await http.get(
        Uri.parse(baseUrl)
        , headers: headers );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      chatRooms.value = data.map((chat) => ChatListDto.fromJson(chat)).toList();
    }else if (response.statusCode == 401) {
      print("응답코드는: ${response.statusCode}");
      Get.snackbar(
        '일시적인 오류로 실패 했습니다',
        '잠시 후 다시 시도 해주세요',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      apiInitialService.accessRequestFromRefresh(_controller.url.value, headers);
      throw Exception('Failed to group detail');
    } else {
      print("응답코드는: ${response.statusCode}");
      Get.snackbar(
        '메시지 목록을 불러오는 것에 실패했습니다',
        '잠시 후 다시 시도 해주세요',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
  