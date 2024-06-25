import 'package:asome/controller/url_token_controller.dart';
import 'package:asome/route/main_route.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  UrlTokenController tokenController = Get.find<UrlTokenController>();

  Future<void> kakaoLogin() async {
    try {
      // 카카오톡 설치 여부 확인
      bool isInstalled = await isKakaoTalkInstalled();
      print('KakaoTalk installed: $isInstalled');

      // 로그인 시도
      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();
      print('OAuthToken: $token');

      // 사용자 정보 가져오기
      User user;
      try {
        user = await UserApi.instance.me();
      } catch (e) {
        // 필요한 동의 항목이 없을 경우 동의 요청
        if (e is KakaoAuthException && e.error == 'insufficient_scope') {
          List<String> requiredScopes = ['account_email', 'profile'];
          token = await UserApi.instance.loginWithNewScopes(requiredScopes);
          user = await UserApi.instance.me();
        } else {
          rethrow;
        }
      }

      String userId = user.id.toString();
      String email = '$userId@kakao.com';
      print('UserId: $userId');
      print('Email: $email');
      String url = "${tokenController.url.value}/api/login/kakao";
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: '{"email": "$email"}',
      );

      print('Server response status: ${response.statusCode}');
      print('Server response body: ${response.body}');

      if (response.statusCode == 200) {
        String? accessToken = response.headers['access-token'];
        String? refreshToken = response.headers['refresh-token'];

        if (accessToken != null && refreshToken != null) {
          tokenController.setAccessToken(accessToken);
          tokenController.setRefreshToken(refreshToken);
          print('Access Token: $accessToken');
          print('Refresh Token: $refreshToken');
          Get.offAndToNamed(MainRoute.intialRoot);
        }


        else {
          print('Tokens not found in response headers');
        }
      } else {
        print('Server error: ${response.statusCode}');
      }
    } catch (error) {
      print('Kakao login error: $error');
    }
  }
}

