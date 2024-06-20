import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../controller/url_token_controller.dart';
import '../model/dto/Post_request_dto.dart';
import '../model/dto/category_dto.dart';
import '../model/dto/comment_dto.dart';

class ApiBoardService {
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
  Future<List<CategoryDto>> fetchCategories() async {
    String baseUrl = "${_controller.url.value}/api/board/category";
    var header = _controller.createHeaders();
    try {
      final response = await http.get(Uri.parse(baseUrl), headers: header);
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
        return data.map((category) => CategoryDto.fromJson(category)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<bool> addPost(PostRequestDto postRequestDto) async {
    String baseUrl = "${_controller.url.value}/api/board/post";
    var headers = _controller.createHeaders();
    headers.addAll({'Content-Type': 'application/json'}) ;
    final body = jsonEncode(postRequestDto.toJson());

    try {
      final response = await http.post(Uri.parse(baseUrl), headers: headers, body: body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<CommentDto> addComment(int postId, String content, [int? parentId]) async {
    String baseUrl = "${_controller.url.value}/api/comment";
    var headers = _controller.createHeaders();
    headers.addAll({'Content-Type': 'application/json'}) ;
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        'postId': postId,
        'content': content,
        'parentId': parentId,
      }),
    );

    if (response.statusCode == 200) {
      return CommentDto.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to add comment');
    }
  }
}

