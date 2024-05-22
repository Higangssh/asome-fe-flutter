import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import '../controller/url_token_controller.dart';
import '../route/main_route.dart';

class ApiLoginService{
  final UrlTokenController controller;

  ApiLoginService(this.controller);

  Future<void> googleRequest(BuildContext context, String url, Map<String, String> headers) async {
    try {
      var response = await http.get(Uri.parse('$url/api/login'), headers: headers);
      if (response.statusCode == 200) {
        Get.offAllNamed(MainRoute.loginWebView);
        print('요청이 성공적으로 보내졌습니다.');
      } else {
        print('요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('오류: $e');
    }
  }

}