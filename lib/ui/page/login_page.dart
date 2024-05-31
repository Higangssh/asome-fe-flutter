import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asome/service/api_login_service.dart';
import 'package:asome/controller/url_token_controller.dart';
import 'package:asome/ui/bar/custom_appbar.dart';

class LoginPage extends GetView<UrlTokenController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiLoginService loginService = ApiLoginService(controller);
    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.webp"), // 경로 수정
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 로그인 UI
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //중앙에 메인 로고
              Container(
                 margin: const EdgeInsets.only(top: 50),
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child:Image.asset(
                    "assets/images/logo.webp",
                    height: 100,
                    width: 100,
                  ),
                )
              ),
              const SizedBox(height: 350,),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        var headers = <String, String>{
                          if (controller.accessToken.value.isNotEmpty && controller.refreshToken.value.isNotEmpty)
                            'access-token': controller.accessToken.value,
                            'refresh-token': controller.refreshToken.value,
                        };
                        loginService.googleRequest(context, controller.url.value, headers);
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
                      height: 5,
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
                      height: 5,
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
        ],
      ),
    );
  }
}



