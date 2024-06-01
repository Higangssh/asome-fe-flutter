
import 'package:asome/model/dto/groupdto.dart';
import 'package:asome/service/api_group_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class GroupController extends GetxController {
  final ApiGroupService apiGroupService = ApiGroupService();
  var groupName = ''.obs;
  var groupLocation = ''.obs;

  void setGroupName(String name) {
    groupName.value = name;
  }

  void setGroupLocation(String location) {
    groupLocation.value = location;
  }

  void createGroup() async{
    // 그룹 생성 로직 추가
    print('그룹 이름: ${groupName.value}');
    print('그룹 위치: ${groupLocation.value}');
    await apiGroupService.createGroup(GroupDto(
      groupName: groupName.value,
      groupLoc: groupLocation.value,
    ));
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

  @override
  void onClose() {
    // 컨트롤러가 더 이상 사용되지 않을 때 호출되는 메서드
    super.onClose();
  }
}