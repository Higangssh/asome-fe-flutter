import 'dart:convert';
import 'dart:math';

import 'package:asome/service/api_initial_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../controller/url_token_controller.dart';
import '../model/dto/groupdto.dart';

class ApiGroupService {

  final UrlTokenController _controller = Get.find<UrlTokenController>();
  late final ApiInitialService apiInitialService;
  ApiGroupService(){
    apiInitialService = ApiInitialService(_controller);
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
      // 성공적으로 생성됨
      Get.snackbar(
        '성공적으로 그룹이 생성되었습니다',
        '그룹 맴버들과 채팅과 매칭을 진행해 보세요',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }else if(response.statusCode == 401){
      print("응답코드는: ${response.statusCode}");
      Get.snackbar(
        '그룹 생성에 실패 했습니다',
        '잠시 후 다시 시도 해주세요',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      apiInitialService.accessRequestFromRefresh(_controller.url.value, headers);
    }else {
      // 오류 처리
      Get.snackbar(
        '그룹생성에 실패 하셨습니다',
        '잠시 후 다시 시도 해주세요',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      throw Exception('Failed to create group');
    }
  }


  Future<List<GroupDto>> requestGroupList() async {
    String baseUrl = "${_controller.url.value}/api/group/list";
    var headers = _controller.createHeaders();
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: headers,
    );

    if (response.statusCode == 200){
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      print("JSON Body: $body");
      List<GroupDto> groupDto = body.map((dynamic item) => GroupDto.fromJson(item)).toList();
      return groupDto;
    }else if(response.statusCode == 401){
      print("응답코드는: ${response.statusCode}");
      Get.snackbar(
        '일시적인 오류로 실패 했습니다',
        '잠시 후 다시 시도 해주세요',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      apiInitialService.accessRequestFromRefresh(_controller.url.value, headers);
    }else{
      // 오류 처리
      Get.snackbar(
        '그룹생성에 실패 하셨습니다',
        '잠시 후 다시 시도 해주세요',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      throw Exception('Failed to create group');
    }
    return [];

  }


  Future<GroupDto> requestGroupDetails(int groupId) async {
    final String url =  "${_controller.url.value}/api/group/detail/$groupId";
    var headers = _controller.createHeaders();

      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      if (response.statusCode == 200) {
        print("JSON Body: ${jsonDecode(response.body)}");
        GroupDto dto =GroupDto.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        return dto;
      }else if(response.statusCode == 401){
        print("응답코드는: ${response.statusCode}");
        Get.snackbar(
          '일시적인 오류로 실패 했습니다',
          '잠시 후 다시 시도 해주세요',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        apiInitialService.accessRequestFromRefresh(_controller.url.value, headers);
        throw Exception('Failed to group detail');
      } else {
        Get.snackbar(
          '그룹 상세 페이지 조회가 실패했습니다',
          '잠시 후 다시 시도 해주세요',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        throw Exception('Failed to group detail');
      }

  }




}