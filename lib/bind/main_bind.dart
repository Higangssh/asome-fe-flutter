import 'package:asome/controller/board_controller.dart';
import 'package:asome/controller/board_detail_controller.dart';
import 'package:asome/controller/bottom_bar_controller.dart';
import 'package:asome/controller/chat_room_controller.dart';
import 'package:asome/controller/form_controller.dart';
import 'package:asome/controller/group_controller.dart';
import 'package:asome/controller/group_detail_controller.dart';
import 'package:asome/controller/profile_controller.dart';
import 'package:asome/controller/url_token_controller.dart';
import 'package:get/get.dart';

class MainBind extends Bindings{
  @override
  void dependencies() {
    Get.put(UrlTokenController(), permanent: true);
    Get.put(FormController());
    Get.put(GroupController());
    Get.put(GroupDetailController());
    Get.lazyPut(() => ChatRoomController());
    Get.put(BottomBarController(),  permanent: true);
    Get.put(BoardListController());
    Get.put(BoardDetailsController());
  }

}