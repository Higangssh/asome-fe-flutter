import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UrlTokenController extends GetxController{
  var url = "http://172.30.1.8:9000".obs;
  var webSocketUrl ='ws://172.30.1.8:9000/ws'.obs;
  var modifyUrl ="172.30.1.8";
  var isLoading = false.obs;
  var accessToken = "".obs;
  var refreshToken = "".obs;
  var gender = "".obs;
  var nick = "".obs;

  Map<String, String> createHeaders() {
    var headers = <String, String>{};
    headers['Content-Type'] = 'application/json';
    if (accessToken.value.isNotEmpty && refreshToken.value.isNotEmpty) {
      headers['access-token'] = accessToken.value;
      headers['refresh-token'] = refreshToken.value;
    }
    return headers;
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

  Future<void> loadGender() async {
    final prefs = await SharedPreferences.getInstance();
    gender.value = prefs.getString('gender') ?? "";
    print(gender.value);
  }

  Future<void> loadNick() async{
    final prefs = await SharedPreferences.getInstance();
    nick.value = prefs.getString('nick') ?? "";
  }

  Future<void> setAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access-token', token);
    accessToken.value = token;
  }

  Future<void> setGender(String gen) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gender', gen);
    gender.value = gen;
  }

  void clearAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access-token');
    accessToken.value = "";
  }

  Future<void> setNick(String nickName)async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nick', nickName);
    nick.value=nickName;
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