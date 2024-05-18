import 'package:asome/controller/url_controller.dart';
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
  late UrlController _urlController;
  @override
  void initState() {
    super.initState();
    _urlController=Get.find<UrlController>();
    _checkApiAndNavigateToMainPage();
  }


  Future<void> _checkApiAndNavigateToMainPage() async {

    _urlController.isLoading.value = true;

    try {
      var response = await http.get(Uri.parse("${_urlController.url.value}/test"));

      if (response.statusCode == 401) {
        Get.offAllNamed(MainRoute.loginRoot);
      }else if (response.statusCode == 200) {
        // 401 상태 코드를 받았을 때 로그인 페이지로 이동합니다.
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
      _urlController.isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(themeData: Theme.of(context),),
      body: Center(
        child: _urlController.isLoading.value
            ? const CircularProgressIndicator() // API 요청 중에는 로딩 표시를 보여줍니다.
            : ElevatedButton(
          onPressed: _checkApiAndNavigateToMainPage,
          child: const Text('네트워크 요청 재시도'),
        ),
      ),
    );
  }
}