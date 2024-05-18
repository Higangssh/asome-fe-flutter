import 'package:asome/bind/main_bind.dart';
import 'package:asome/ui/page/initial_page.dart';
import 'package:asome/ui/page/login_page.dart';
import 'package:asome/ui/page/main_page.dart';
import 'package:get/get.dart';

class MainRoute{

  static const String intialRoot ="/";
  static const String loginRoot = "/login";
  static const String mainRoot = "/main";

  static List<GetPage> pages =[
    GetPage(name: intialRoot , page : ()=> const InitialPage(), binding: MainBind()),
    GetPage(name: loginRoot, page: ()=> LoginPage()),
    GetPage(name: mainRoot, page: ()=> const MainPage())
  ];
}