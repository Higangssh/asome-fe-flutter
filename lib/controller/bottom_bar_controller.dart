import 'package:get/get.dart';

import '../route/main_route.dart';

class BottomBarController extends GetxController {
  var currentIndex = 0.obs;

  void changePage(int index) {
    print(currentIndex.value);
    currentIndex.value = index;
    print(currentIndex.value);
    switch (index) {
      case 0:
        Get.offAndToNamed(MainRoute.mainRoot); // 홈 페이지로 이동
        break;
      case 1:
        Get.offAndToNamed('/forum'); // 게시판 페이지로 이동
        break;
      case 2:
        Get.offAndToNamed(MainRoute.chatRoomListRoot); // 메시지 페이지로 이동
        break;
    }
  }
}