import 'package:asome/controller/url_token_controller.dart';
import 'package:get/get.dart';

class MainBind extends Bindings{
  @override
  void dependencies() {
    Get.put(UrlTokenController());
  }

}