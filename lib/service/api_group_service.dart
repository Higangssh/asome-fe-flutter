import 'dart:convert';
import 'dart:ffi';
import 'package:asome/model/dto/group_dto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../controller/url_token_controller.dart';
import 'api_initial_service.dart';

class ApiGroupService {
  final UrlTokenController _controller = Get.find<UrlTokenController>();
  late final ApiInitialService apiInitialService;

  ApiGroupService() {
    apiInitialService = ApiInitialService(_controller);
  }

  Future<List<GroupDto>> requestInvitedGroupList() async {
    String requestUrl = '${_controller.url.value}/api/group/request/list';
    final response = await http.get(Uri.parse(requestUrl), headers: _controller.createHeaders());

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      List<GroupDto> groupRequests = body.map((dynamic item) => GroupDto.fromJson(item)).toList();
      return groupRequests;
    } else {
      _handleError(response);
      return [];
    }
  }

  Future<void> createGroup(GroupDto dto) async {
    String baseUrl = "${_controller.url.value}/api/group/create";
    var headers = _controller.createHeaders();
    dto.gender = _controller.gender.value;
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: headers,
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode == 200) {
      Get.snackbar(
        '성공적으로 그룹이 생성되었습니다',
        '그룹 맴버들과 채팅과 매칭을 진행해 보세요',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      _handleError(response);
    }
  }

  Future<List<GroupDto>> requestGroupList() async {
    String baseUrl = "${_controller.url.value}/api/group/list";
    var headers = _controller.createHeaders();
    final response = await http.get(Uri.parse(baseUrl), headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      List<GroupDto> groupDto = body.map((dynamic item) => GroupDto.fromJson(item)).toList();
      return groupDto;
    } else {
      _handleError(response);
      return [];
    }
  }

  Future<GroupDto> requestGroupDetails(int groupId) async {
    final String url = "${_controller.url.value}/api/group/detail/$groupId";
    var headers = _controller.createHeaders();

    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      GroupDto dto = GroupDto.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      return dto;
    } else {
      _handleError(response);
      return Future.error('Failed to get group details');
    }
  }

  Future<bool> acceptRequest(int groupId) async {
    String requestUrl = '${_controller.url.value}/api/group/request/accept?groupId=$groupId';
    final response = await http.get(Uri.parse(requestUrl), headers: _controller.createHeaders());

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as bool;
    } else {
      _handleError(response);
      return false;
    }
  }

  void _handleError(http.Response response) {
    if (response.statusCode == 401) {
      print("응답코드는: ${response.statusCode}");
      Get.snackbar(
        '일시적인 오류로 실패 했습니다',
        '잠시 후 다시 시도 해주세요',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      apiInitialService.accessRequestFromRefresh(_controller.url.value, _controller.createHeaders());
    } else {
      Get.snackbar(
        '요청이 실패했습니다',
        '잠시 후 다시 시도 해주세요',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      throw Exception('Failed to process request');
    }
  }
}
