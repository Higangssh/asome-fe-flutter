import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../controller/url_token_controller.dart';
import '../model/dto/comment_dto.dart';

class ApiCommentService {
  final UrlTokenController _controller = Get.find<UrlTokenController>();

  Future<List<CommentDto>> fetchComments(int postId, int pageNum) async {
    String baseUrl = "${_controller.url.value}/api/comment/list?postId=$postId&pageNum=$pageNum";
    var header = _controller.createHeaders();
    try {
      final response = await http.get(Uri.parse(baseUrl), headers: header);
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
        return data.map((comment) => CommentDto.fromJson(comment)).toList();
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      throw Exception('Failed to load comments: $e');
    }
  }
}

