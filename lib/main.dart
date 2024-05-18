import 'package:asome/bind/main_bind.dart';
import 'package:asome/route/main_route.dart';
import 'package:asome/ui/page/initial_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MainRoute.intialRoot,
      getPages: MainRoute.pages,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue
      ),
    );
  }

}
