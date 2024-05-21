import 'package:asome/controller/url_token_controller.dart';
import 'package:asome/ui/bar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(themeData: Theme.of(context),),
      body: const Center(
        child: Text('메인 페이지'),
      ),
    );
  }
}