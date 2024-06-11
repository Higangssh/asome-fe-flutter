import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomChatAppBar extends StatelessWidget implements PreferredSizeWidget {

  final ThemeData themeData;

  const CustomChatAppBar({
    super.key,
    required this.themeData, // 생성자 매개변수로 ThemeData 추가
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "채팅",
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
      backgroundColor: HexColor("#00E8C1"),

    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}