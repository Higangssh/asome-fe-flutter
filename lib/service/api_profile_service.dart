import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import '../controller/url_token_controller.dart';
import '../model/dto/board_detail_list_dto.dart';
import '../model/dto/profile_dto.dart';

class ApiProfileService{
  final UrlTokenController urlTokenController = Get.put(UrlTokenController());


  Future<ProfileResponseDto> fetchProfile() async {
    String baseUrl = "${urlTokenController.url.value}/api/profile/list";
    var headers = urlTokenController.createHeaders();
    final response = await http.get(Uri.parse(baseUrl),headers: headers);
    if (response.statusCode == 200) {
      return ProfileResponseDto.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<List<BoardDetailsDto>> fetchMyPosts(int pageNum) async {
    String baseUrl = "${urlTokenController.url.value}/api/board/post/list/me?pageNum=$pageNum";
    var headers = urlTokenController.createHeaders();
    final response = await http.get(Uri.parse(baseUrl), headers: headers);
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((data) => BoardDetailsDto.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load my posts');
    }
  }

  Future<List<BoardDetailsDto>> fetchMyScraps(int pageNum) async {
    String baseUrl = "${urlTokenController.url.value}/api/board/scrap/list?pageNum=$pageNum";
    var headers = urlTokenController.createHeaders();
    final response = await http.get(Uri.parse(baseUrl), headers: headers);
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((data) => BoardDetailsDto.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load my scraps');
    }
  }

  Future<bool> fetchLogout() async {
    String baseUrl = "${urlTokenController.url.value}/api/logout";
    var headers = urlTokenController.createHeaders();
    final response = await http.post(Uri.parse(baseUrl), headers: headers);
    if (response.statusCode == 200) {
        urlTokenController.clearAccessToken();
        urlTokenController.clearRefreshToken();
        return true;
    } else {
        return false;
    }
  }
}