import 'package:asome/controller/url_token_controller.dart';
import 'package:asome/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // UrlTokenController 초기화
  final urlTokenController = Get.put(UrlTokenController());
  // 액세스 토큰과 리프레시 토큰 로딩
  await urlTokenController.loadAccessToken();
  await urlTokenController.loadRefreshToken();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MainRoute.intialRoot,
      getPages: MainRoute.pages,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue
      ),
    );
  }

}