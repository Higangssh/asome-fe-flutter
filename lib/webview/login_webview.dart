import 'package:asome/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controller/url_token_controller.dart';
import '../ui/bar/custom_appbar.dart';
import 'package:http/http.dart' as http;

class LoginWebView extends StatefulWidget {
  const LoginWebView({super.key});

  @override
  _LoginWebViewState createState() => _LoginWebViewState();
}

class _LoginWebViewState extends State<LoginWebView> {


  late WebViewController _webViewController;
  final cookieManager = WebviewCookieManager();

  // 로그인 성공 후 리다이렉트 될 URL의 호스트를 변경할 함수
  String changeRedirectHost(String originalUrl, String modifyUrl) {
    // 로그인 성공 후 리다이렉트 될 URL에서 호스트를 172.18.35.233로 변경
    Uri originalUri = Uri.parse(originalUrl);
    Uri modifiedUri = originalUri.replace(host: modifyUrl);
    return modifiedUri.toString();
  }

  @override
  Widget build(BuildContext context) {
    final UrlTokenController urlTokenController = Get.find<UrlTokenController>();
    final String initialUrl = '${urlTokenController.url.value}/login';
    return Scaffold(
      appBar: CustomAppBar(themeData: Theme.of(context),),
      body: SafeArea(
        child: WebView(
          initialUrl: initialUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _webViewController = webViewController;

          },
          userAgent: "random",
          navigationDelegate: (NavigationRequest request) {
            // 로그인 성공 후에만 처리
            if (request.url.contains('http://localhost:9000/login/oauth2/code/google?state')) {
              // 리다이렉트될 URL의 호스트를 변경하여 이동
              String modifiedUrl = changeRedirectHost(request.url, urlTokenController.modifyUrl);
              _webViewController.loadUrl(modifiedUrl);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) async {
            // 페이지 로드 완료 시에 응답 코드 확인
            final int? statusCode = await _webViewController.currentUrl().then((url) async {
              final response = await http.get(Uri.parse(url!),
                  headers: {"Accept": "application/json",});
              print('응답 코드: ${response.statusCode}');
              final gotCookies = await cookieManager.getCookies(url);
              for (var item in gotCookies) {
                print(item);
                if (item.name == 'access-token') {
                  await urlTokenController.setAccessToken(item.value);
                }else if(item.name == 'refresh-token'){
                  await urlTokenController.setRefreshToken(item.value);
                }
              }
              //await cookieManager.clearCookies();
              return response.statusCode;

            });
            if (statusCode == 201) {
              // 응답 코드가 201일 경우에만 MainPage로 이동
              if (mounted) {
                Get.offAllNamed(MainRoute.intialRoot);
              }
            }else if(statusCode == 401){
              Get.offAllNamed(MainRoute.loginRoot);
            }
          },

        ),
      ),

    );
  }
}