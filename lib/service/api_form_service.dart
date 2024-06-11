import 'dart:convert';

import 'package:asome/model/dto/member_dto.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../controller/url_token_controller.dart';

class ApiFormService{

  final UrlTokenController _controller = Get.find<UrlTokenController>();


   Future<bool> checkNicknameApi(String nickname) async {
     String baseUrl = "${_controller.url.value}/api/member/nick";
     var headers = <String, String>{};
     if (_controller.accessToken.value.isNotEmpty && _controller.refreshToken.value.isNotEmpty) {
       headers['access-token'] = _controller.accessToken.value;
       headers['refresh-token'] = _controller.refreshToken.value;
     }
     var response = await http.get(Uri.parse(baseUrl)
         .replace(queryParameters: {'nick': nickname}),headers: headers);
     if (response.statusCode == 200) {
       bool isNickExist = jsonDecode(response.body) as bool;
       return isNickExist;
     } else {
       // 에러 처리
       print('Request failed with status: ${response.statusCode}.');
       return false;
     }
  }

  Future<bool> searchSchoolNameApi(String schoolName) async{
    String baseUrl = "${_controller.url.value}/api/university/check";
    var headers = <String, String>{
      'Content-Type': 'application/json',
    };
    if (_controller.accessToken.value.isNotEmpty && _controller.refreshToken.value.isNotEmpty) {
      headers['access-token'] = _controller.accessToken.value;
      headers['refresh-token'] = _controller.refreshToken.value;
    }
    var body = jsonEncode({'universityName': schoolName});
    var response = await http.post(Uri.parse(baseUrl), headers: headers, body: body);

    if (response.statusCode == 200) {
      bool isSuccess = jsonDecode(response.body) as bool;
      return isSuccess;
    } else {
      // 에러 처리
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }
  }

  Future<bool> sendSchoolEmail(String schoolName,String email) async {
    String baseUrl = "${_controller.url.value}/api/university/email";
    var headers = <String, String>{
      'Content-Type': 'application/json',
    };
    if (_controller.accessToken.value.isNotEmpty && _controller.refreshToken.value.isNotEmpty) {
      headers['access-token'] = _controller.accessToken.value;
      headers['refresh-token'] = _controller.refreshToken.value;
    }
    var body = jsonEncode({'universityName': schoolName, 'email': email});
    var response = await http.post(Uri.parse(baseUrl), headers: headers, body: body);

    if (response.statusCode == 200) {
      bool isSuccess = jsonDecode(response.body) as bool;
      return isSuccess;
    } else {
      // 에러 처리
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }
  }

  Future<bool> verifyEmailCode (String schoolName,String email, String code) async{
    String baseUrl = "${_controller.url.value}/api/university/code";
    var headers = <String, String>{
      'Content-Type': 'application/json',
    };
    if (_controller.accessToken.value.isNotEmpty && _controller.refreshToken.value.isNotEmpty) {
      headers['access-token'] = _controller.accessToken.value;
      headers['refresh-token'] = _controller.refreshToken.value;
    }
    int intCode = int.parse(code);
    var body = jsonEncode({'universityName': schoolName, 'email': email, 'code':intCode});
    var response = await http.post(Uri.parse(baseUrl), headers: headers, body: body);

    if (response.statusCode == 200) {
      bool isSuccess = jsonDecode(response.body) as bool;
      return isSuccess;
    } else {
      // 에러 처리
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }
  }

  Future<void> submitEssentialInfoAndGetNewAccessToken(MemberDto dto)async {
    String baseUrl = "${_controller.url.value}/api/member/update";
    var headers = <String, String>{
      'Content-Type': 'application/json',
    };
    if (_controller.accessToken.value.isNotEmpty && _controller.refreshToken.value.isNotEmpty) {
      headers['access-token'] = _controller.accessToken.value;
      headers['refresh-token'] = _controller.refreshToken.value;

    }
    var body = jsonEncode(dto.toJson());
    var response = await http.post(Uri.parse(baseUrl), headers: headers, body: body);
    if (response.statusCode == 200) {
       String accessJws =  response.body;
       print("accessJws : $accessJws");
       _controller.setAccessToken(accessJws);
       _controller.setNick(dto.nick!);
       print('새 엑세스 성공');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

}