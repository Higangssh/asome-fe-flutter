import 'package:asome/controller/url_token_controller.dart';
import 'package:asome/route/main_route.dart';
import 'package:asome/ui/bar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginPage extends GetView<UrlTokenController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(themeData: Theme.of(context),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 중앙에 메인 로고
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: Image.asset(
              "assets/images/logo.png",
              height: 250,
              width: 250,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    var headers = <String, String>{
                      if (controller.accessToken.value.isNotEmpty && controller.refreshToken.value.isNotEmpty)
                        'access-token': controller.accessToken.value,
                        'refresh-token': controller.refreshToken.value
                    };
                    _googleRequest(context,controller.url.value,headers);
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(10),
                  ),
                  child: Container(
                    height: 50,
                    width: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20), // 모서리 반경 설정
                      child: Image.asset(
                        "assets/images/google.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    // 카카오 로그인 처리
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(10),
                  ),
                  child: Container(
                    height: 50,
                    width: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20), // 모서리 반경 설정
                      child: Image.asset(
                        "assets/images/kakao.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    // 네이버 로그인 처리
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(10),
                  ),
                  child: Container(
                    height: 50,
                    width: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20), // 모서리 반경 설정
                      child: Image.asset(
                        "assets/images/naver.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
void _googleRequest(BuildContext context,String url, headers) async {
  try {
    var response = await http.get(Uri.parse('$url/test'),headers: headers); // 예시 URL로 변경
    if (response.statusCode == 200) {
      // 성공적으로 요청을 보냈을 때의 처리
     Get.offAllNamed(MainRoute.loginWebView);
      print('요청이 성공적으로 보내졌습니다.');

    } else {
      // 요청이 실패했을 때의 처리
      print('요청 실패: ${response.statusCode}');
    }
  } catch (e) {
    // 예외 처리
    print('오류: $e');
  }
}
