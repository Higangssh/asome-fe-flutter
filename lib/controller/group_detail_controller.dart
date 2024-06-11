import 'dart:convert';
import 'package:asome/service/api_group_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../model/dto/group_dto.dart';
import 'package:http/http.dart' as http;

class GroupDetailController extends GetxController {
  ApiGroupService groupService = ApiGroupService();
  var group = GroupDto(
    id: 0 ,
    groupName: '',
    groupLoc: '',
    total: 0,
    gender: '',
    isMatch: '',
    members: [],
  ).obs;

  void setGroup(GroupDto newGroup) {
    group.value = newGroup;
  }



  Future<void> fetchGroupDetails(int groupId) async {
    GroupDto dto =await groupService.requestGroupDetails(groupId);
    setGroup(dto);
  }


  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy년 MM월 dd일');
    return formatter.format(date);
  }


}