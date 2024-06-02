import 'dart:async';
import 'package:get/get.dart';

class MessageController extends GetxController {
  var messages = [
    '매칭을 진행해 보세요!',
    '그룹을 만들어보세요',
    '오늘 행복하세요',
  ].obs;

  var currentMessageIndex = 0.obs;

  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      currentMessageIndex.value = (currentMessageIndex.value + 1) % messages.length;
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  String get currentMessage => messages[currentMessageIndex.value];
}
