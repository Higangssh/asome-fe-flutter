import 'package:asome/bind/main_bind.dart';
import 'package:asome/model/dto/chatroomdto.dart';
import 'package:asome/ui/page/chat_page.dart';
import 'package:asome/ui/page/chat_room_page.dart';
import 'package:asome/ui/page/group_detail_page.dart';
import 'package:asome/ui/page/initial_page.dart';
import 'package:asome/ui/page/input_page.dart';
import 'package:asome/ui/page/login_page.dart';
import 'package:asome/ui/page/main_page.dart';
import 'package:asome/webview/login_webview.dart';
import 'package:get/get.dart';

class MainRoute{

  static const String intialRoot ="/";
  static const String loginRoot = "/login";
  static const String mainRoot = "/main";
  static const String loginWebView = "/login/webview";
  static const String inputFormRoot = "/form";
  static const String chatRoomListRoot = "/chat/room";
  static const String groupDetailRoot = "/group/detail";

  static List<GetPage> pages =[
    GetPage(name: intialRoot , page : ()=> const InitialPage(), binding: MainBind()),
    GetPage(name: loginRoot, page: ()=> LoginPage()),
    GetPage(name: mainRoot, page: ()=>  MainPage() ,binding: MainBind()),
    GetPage(name: loginWebView, page: ()=> LoginWebView()),
    GetPage(name: inputFormRoot, page: ()=> FormPage()),
    GetPage(name: chatRoomListRoot, page: ()=> ChatRoomListPage()),
    GetPage(
      name: groupDetailRoot,
      page: () => GroupDetailPage(groupId: Get.arguments),
      binding: MainBind(),
    ),
  ];
}