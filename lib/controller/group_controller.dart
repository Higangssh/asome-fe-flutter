import 'dart:ffi';

import 'package:asome/model/dto/group_dto.dart';
import 'package:asome/service/api_group_service.dart';
import 'package:get/get.dart';

class GroupController extends GetxController {
  final ApiGroupService apiGroupService = ApiGroupService();
  var groupName = ''.obs;
  var groupLocation = ''.obs;
  var invitedGroupList = <GroupDto>[].obs;

  @override
  void onInit() {
    super.onInit();
    getInvitedGroupList(); // 컨트롤러 초기화 시 데이터를 가져옵니다
  }

  void setGroupName(String name) {
    groupName.value = name;
  }

  void setGroupLocation(String location) {
    groupLocation.value = location;
  }

  void createGroup() async {
    print('그룹 이름: ${groupName.value}');
    print('그룹 위치: ${groupLocation.value}');
    await apiGroupService.createGroup(GroupDto(
      groupName: groupName.value,
      groupLoc: groupLocation.value,
    ));
  }

  Future<void> getInvitedGroupList() async {
    try {
      List<GroupDto> groups = await apiGroupService.requestInvitedGroupList();
      invitedGroupList.value = groups;
    } catch (e) {
      print("Error getting invited group list: $e");
    }
  }

  Future<List<GroupDto>> getListGroup() async {
    try {
      List<GroupDto> dto = await apiGroupService.requestGroupList();
      return dto;
    } catch (e) {
      print("Error getting group list: $e");
      return [];
    }
  }

  Future<bool> acceptRequest(int groupId) async {
    try {
      return await apiGroupService.acceptRequest(groupId);
    } catch (e) {
      print("Error accepting request: $e");
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
