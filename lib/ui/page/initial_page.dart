import 'dart:convert';

import 'package:asome/controller/url_token_controller.dart';
import 'package:asome/route/main_route.dart';
import 'package:asome/ui/bar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  late UrlTokenController _urlTokenController;

  @override
  void initState() {
    super.initState();
    _urlTokenController= Get.find<UrlTokenController>();
    print('access: ${_urlTokenController.accessToken.value}');
    _checkApiAndNavigateToMainPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(themeData: Theme.of(context),),
      body: Center(
        child: _urlTokenController.isLoading.value
            ? const CircularProgressIndicator() // API 요청 중에는 로딩 표시를 보여줍니다.
            : ElevatedButton(
          onPressed: _checkApiAndNavigateToMainPage,
          child: const Text('네트워크 요청 재시도'),
        ),
      ),
    );
  }

  Future<void> _checkApiAndNavigateToMainPage() async {

    _urlTokenController.isLoading.value = true;

    try {
      var headers = <String, String>{
        if (_urlTokenController.accessToken.value.isNotEmpty && _urlTokenController.refreshToken.value.isNotEmpty)
          'access-token': _urlTokenController.accessToken.value,
          'refresh-token':_urlTokenController.refreshToken.value
      };
      var response = await http.get(Uri.parse("${_urlTokenController.url.value}/api/access"),headers: headers);
      if (response.statusCode == 404) {
        //404 일경우 로그인 페이지로 이동
        Get.offAllNamed(MainRoute.loginRoot);
      }else if (response.statusCode == 401) {
        // 401 상태 코드를 받았을 때 refresh 를 통해 access 재발급 받는 페이지로 요청
        accessRequestFromRefresh(context, _urlTokenController.url.value,headers);
      }
      else if (response.statusCode == 200) {
        // 200 상태 코드를 받았을 때 메인 페이지로 이동
        Get.offAllNamed(MainRoute.mainRoot);
      } else {
        print('서버 응답: ${response.statusCode}');
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
    } catch (error) {
      if (error is http.ClientException) {
        // 클라이언트 예외가 발생한 경우 (HTTP 요청에 문제가 있는 경우)
        print('클라이언트 예외: ${error.message}');
      } else {
        // 그 외의 예상치 못한 에러가 발생한 경우
        print('에러: $error');
      }
    } finally {
      _urlTokenController.isLoading.value = false;
    }
  }

  void accessRequestFromRefresh(BuildContext context,String url, headers) async {
    try {
      // headers에서 refresh-token 값을 가져옴
      String? refreshToken = headers['refresh-token'];
      headers['Content-Type'] = 'application/json';
      print("refreshToken : ${refreshToken}");
      // refresh-token이 존재하지 않으면 예외 처리
      if (refreshToken == null) {
        print('오류: refresh-token이 headers에 존재하지 않습니다.');
        return;
      }
      var body = jsonEncode({'refresh_jws': refreshToken});
      var response = await http.post(
          Uri.parse('$url/api/refresh'), headers: headers, body:body); // 예시 URL로 변경
      if (response.statusCode == 200) {
        // 성공적으로 요청을 보냈을 때의 처리
        final newAccessJws = response.body;
        await _urlTokenController.setAccessToken(newAccessJws);
        Get.offAllNamed(MainRoute.mainRoot);
        print('요청이 성공적으로 보내졌습니다.');
      } else if(response.statusCode == 401) {
        // 요청이 실패했을 때의 처리
        print('/api/refresh 요청 실패: ${response.statusCode}');
        Get.offAllNamed(MainRoute.loginRoot);

      }
    } catch (e) {
      // 예외 처리
      print('오류: $e');
    }
  }
}