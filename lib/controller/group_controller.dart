
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CreateGroupController extends GetxController {
  var groupName = ''.obs;
  var groupLocation = ''.obs;

  void setGroupName(String name) {
    groupName.value = name;
  }

  void setGroupLocation(String location) {
    groupLocation.value = location;
  }

  void createGroup() {
    // 그룹 생성 로직 추가
    print('그룹 이름: ${groupName.value}');
    print('그룹 위치: ${groupLocation.value}');
    // 이후 로직 예: 서버에 그룹 생성 요청 등
  }

  @override
  void onClose() {
    // 컨트롤러가 더 이상 사용되지 않을 때 호출되는 메서드
    super.onClose();
  }
}