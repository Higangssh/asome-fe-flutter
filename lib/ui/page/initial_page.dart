import 'package:asome/ui/bar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login_page.dart';
import 'main_page.dart';


class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {

  @override
  void initState() {
    super.initState();
    _checkApiAndNavigateToMainPage();
  }

  bool _isLoading = false;
  final _url = Uri.parse('http://172.18.32.138:9000/test');

  Future<void> _checkApiAndNavigateToMainPage() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var response = await http.get(_url);

      if (response.statusCode == 401) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      }else if (response.statusCode == 200) {
        // 401 상태 코드를 받았을 때 로그인 페이지로 이동합니다.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()), // 로그인 페이지로 이동
        );
      } else {
        print('서버 응답: ${response.statusCode}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('API 요청이 실패하였습니다.'),
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
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(themeData: Theme.of(context),),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator() // API 요청 중에는 로딩 표시를 보여줍니다.
            : ElevatedButton(
          onPressed: _checkApiAndNavigateToMainPage,
          child: const Text('API 확인 후 메인 페이지로 이동'),
        ),
      ),
    );
  }
}