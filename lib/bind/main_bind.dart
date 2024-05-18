import 'package:asome/controller/url_controller.dart';
import 'package:get/get.dart';

class MainBind extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UrlController>(()=>UrlController());
  }

}