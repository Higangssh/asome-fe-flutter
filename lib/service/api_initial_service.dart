import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controller/url_token_controller.dart';
import '../route/main_route.dart';

class ApiInitialService {
  final UrlTokenController controller;

  ApiInitialService(this.controller);

  Future<void> checkApiAndNavigateToMainPage(BuildContext context) async {
    controller.isLoading.value = true;
    try {
      var headers = <String, String>{
        'access-token': controller.accessToken.value,
        'refresh-token': controller.refreshToken.value,
        'Content-Type': 'application/json',
      };
      print("accees-token: ${controller.accessToken.value} ");
      print("refresh-token: ${controller.refreshToken.value} ");
      print("${controller.url.value}/api/access");

      var response = await http.get(
        Uri.parse("${controller.url.value}/api/access"),
        headers: headers,
      );

      if (response.statusCode == 404 || response.statusCode == 403) {
        Get.offAllNamed(MainRoute.loginRoot);
      } else if (response.statusCode == 401) {
        await accessRequestFromRefresh(controller.url.value, headers);
      } else if (response.statusCode == 200) {
        Get.offAllNamed(MainRoute.mainRoot);
      } else if (response.statusCode == 201) {
        Get.offAllNamed(MainRoute.inputFormRoot);
      } else {
        print('서버 응답: ${response.statusCode}');
        _showErrorDialog(context);
      }
    } catch (error) {
      if (error is http.ClientException) {
        print('클라이언트 예외: ${error.message}');
      } else {
        print('에러: $error');
      }
    } finally {
      controller.isLoading.value = false;
    }
  }

  Future<void> accessRequestFromRefresh(String url, Map<String, String> headers) async {
    try {
      String? refreshToken = headers['refresh-token'];
      headers['Content-Type'] = 'application/json';
      print("refreshToken : $refreshToken");

      if (refreshToken == null) {
        print('오류: refresh-token이 headers에 존재하지 않습니다.');
        return;
      }

      var body = jsonEncode({'refresh_jws': refreshToken});
      var response = await http.post(
        Uri.parse('$url/api/refresh'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final newAccessJws = response.body;
        await controller.setAccessToken(newAccessJws);
        Get.offAllNamed(MainRoute.mainRoot);
        print('요청이 성공적으로 보내졌습니다.');
      } else if (response.statusCode == 401) {
        print('/api/refresh 요청 실패: ${response.statusCode}');
        Get.offAllNamed(MainRoute.loginRoot);
      }
    } catch (e) {
      print('오류: $e');
    }
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('네트워크 요청이 실패하였습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
