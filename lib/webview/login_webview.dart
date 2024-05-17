import 'package:asome/ui/page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../ui/bar/custom_appbar.dart';
import 'package:http/http.dart' as http;

class LoginWebview extends StatefulWidget {
  const LoginWebview({super.key});

  @override
  _LoginWebviewState createState() => _LoginWebviewState();
}

class _LoginWebviewState extends State<LoginWebview> {


  late WebViewController _webViewController;
  final String initialUrl = 'http://172.18.35.233:9000/login';


  // 로그인 성공 후 리다이렉트 될 URL의 호스트를 변경할 함수
  String changeRedirectHost(String originalUrl) {
    // 로그인 성공 후 리다이렉트 될 URL에서 호스트를 172.18.35.233로 변경
    Uri originalUri = Uri.parse(originalUrl);
    Uri modifiedUri = originalUri.replace(host: '172.18.35.233');
    return modifiedUri.toString();
  }

  @override
  Widget build(BuildContext context) {
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
              String modifiedUrl = changeRedirectHost(request.url);
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
              Map<String, String> headers = response.headers;
              String? accessToken = headers['access-token'];
              String? refreshToken = headers['refresh-token'];
              print('Access Token: $accessToken');
              print('Refresh Token: $refreshToken');
              return response.statusCode;
            });
            if (statusCode == 201) {
              // 응답 코드가 302일 경우에만 MainPage로 이동
              if (mounted) {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MainPage()));
              }
            }
          },
        ),
      ),
    );
  }
}