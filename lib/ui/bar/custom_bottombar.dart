import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../controller/bottom_bar_controller.dart';

class CustomBottomBar extends StatelessWidget {
  final BottomBarController controller = Get.find<BottomBarController>();

   CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.house),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.person),
          label: 'My',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.solidComments),
          label: '메시지',
        ),
      ],
      currentIndex: controller.currentIndex.value,
      selectedItemColor: HexColor("#00E8C1"),
      onTap: controller.changePage,
    ));
  }
}