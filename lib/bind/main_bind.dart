import 'package:asome/controller/bottom_bar_controller.dart';
import 'package:asome/controller/chat_room_controller.dart';
import 'package:asome/controller/form_controller.dart';
import 'package:asome/controller/group_controller.dart';
import 'package:asome/controller/group_detail_controller.dart';
import 'package:asome/controller/url_token_controller.dart';
import 'package:get/get.dart';

class MainBind extends Bindings{
  @override
  void dependencies() {
    Get.put(UrlTokenController());
    Get.put(FormController());
    Get.put(GroupController());
    Get.put(GroupDetailController());
    Get.lazyPut(() => ChatRoomController());
    Get.lazyPut(() => BottomBarController());

  }

}