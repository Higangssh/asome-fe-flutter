import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../controller/url_token_controller.dart';
import '../model/dto/board_detail_list_dto.dart';

class ApiPostService {
  final UrlTokenController urlTokenController = Get.find<UrlTokenController>();

  Future<List<BoardDetailsDto>> fetchBoardDetails(int id) async {
    final url = "${urlTokenController.url.value}/api/board/post/list?commonId=$id";
    final header = urlTokenController.createHeaders();
    final response = await http.get(Uri.parse(url), headers: header);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(utf8.decode(response.bodyBytes));
      return jsonList.map((json) => BoardDetailsDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load board details');
    }
  }

  Future<List<BoardDetailsDto>> fetchBoardMoreDetails(int id, int pageNum ) async {

    print(pageNum);
    final url = "${urlTokenController.url.value}/api/board/post/list?commonId=$id&pageNum=$pageNum";
    final header = urlTokenController.createHeaders();
    final response = await http.get(Uri.parse(url), headers: header);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(utf8.decode(response.bodyBytes));
      return jsonList.map((json) => BoardDetailsDto.fromJson(json)).toList();
    } else {
      print("else");
      throw Exception('Failed to load board details');
    }
  }

  Future<bool> fetchLikeCount(int postId) async {

    final url = "${urlTokenController.url.value}/api/board/post/like?postId=$postId";
    final header = urlTokenController.createHeaders();
    try {
      final response = await http.post(Uri.parse(url), headers:  header);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to toggle like: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error toggling like: $e');
      return false;
    }
  }

}

