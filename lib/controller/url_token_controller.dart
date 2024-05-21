import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UrlTokenController extends GetxController{
  var url = "http://172.18.40.255:9000".obs;
  var modifyUrl ="172.18.40.255";
  var isLoading = false.obs;
  var accessToken = "".obs;
  var refreshToken = "".obs;

  @override
  void onInit() {
    super.onInit();
  }


  Future<void> loadAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken.value = prefs.getString('access-token') ?? "";
    print(accessToken.value);
  }
  Future<void> loadRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    refreshToken.value = prefs.getString('refresh-token') ?? "";
    print(refreshToken.value);
  }

  Future<void> setAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access-token', token);
    accessToken.value = token;
  }

  void clearAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access-token');
    accessToken.value = "";
  }

  Future<void> setRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('refresh-token', token);
    refreshToken.value = token;
  }

  void clearRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('refresh-token');
    refreshToken.value = "";
  }
}