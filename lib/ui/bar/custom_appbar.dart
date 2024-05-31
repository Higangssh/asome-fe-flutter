import 'package:asome/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final ThemeData themeData;

  CustomAppBar({
    super.key,
    required this.themeData, // 생성자 매개변수로 ThemeData 추가
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'assets/images/appbar-icon.png', // 로고 이미지 경로
        height: 150, // 로고의 높이를 조정합니다.
        width: 150,
      ),
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24
      ),
      centerTitle: true,
      backgroundColor: themeData.primaryColor,
      leading: IconButton(
        icon: const Icon(Icons.home), // 홈 버튼 아이콘
        onPressed: () {
            Get.offAllNamed(MainRoute.mainRoot) ;// intial page로이동
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}