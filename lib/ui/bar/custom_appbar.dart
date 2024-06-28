import 'package:asome/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ThemeData themeData;
  final int notificationCount;

  CustomAppBar({
    super.key,
    required this.themeData, // 생성자 매개변수로 ThemeData 추가
    this.notificationCount = 0, // 기본 알림 개수는 0으로 설정
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
        fontSize: 24,
      ),
      centerTitle: true,
      backgroundColor: themeData.primaryColor,
      // leading: IconButton(
      //   icon: const Icon(Icons.home), // 홈 버튼 아이콘
      //   onPressed: () {
      //     Get.offAllNamed(MainRoute.mainRoot); // 초기 페이지로 이동
      //   },
      // ),
      actions: <Widget>[
        Stack(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.black ,size: 27,), // 테두리 하트 아이콘
              onPressed: () {
                Get.toNamed(MainRoute.groupRequestRoot);
              },
            ),
            if (notificationCount > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Center(
                    child: Text(
                      '$notificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 30),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
