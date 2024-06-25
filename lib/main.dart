import 'package:asome/controller/url_token_controller.dart';
import 'package:asome/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  print( dotenv.env['KAKAO_APP_KEY']);
  KakaoSdk.init(nativeAppKey:  dotenv.env['KAKAO_APP_KEY']);

  String keyHash = await KakaoSdk.origin;
  print('KeyHash: $keyHash');
  // UrlTokenController 초기화
  final urlTokenController = Get.put(UrlTokenController());
  // 액세스 토큰과 리프레시 토큰 로딩
  await urlTokenController.loadAccessToken();
  await urlTokenController.loadRefreshToken();
  await urlTokenController.loadGender();
  await urlTokenController.loadNick();

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        primaryColor: Colors.white,
      ),
    );
  }

}