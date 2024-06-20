import 'package:asome/bind/main_bind.dart';
import 'package:asome/model/dto/chat_room_dto.dart';
import 'package:asome/ui/dialog/create_group_dialog.dart';
import 'package:asome/ui/page/board_detail_page.dart';
import 'package:asome/ui/page/chat_page.dart';
import 'package:asome/ui/page/chat_room_page.dart';
import 'package:asome/ui/page/group_detail_page.dart';
import 'package:asome/ui/page/initial_page.dart';
import 'package:asome/ui/page/input_page.dart';
import 'package:asome/ui/page/login_page.dart';
import 'package:asome/ui/page/main_page.dart';
import 'package:asome/ui/page/post_page.dart';
import 'package:asome/ui/page/post_write_page.dart';
import 'package:asome/webview/login_webview.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../ui/page/group_request_page.dart';

class MainRoute{

  static const String intialRoot ="/";
  static const String loginRoot = "/login";
  static const String mainRoot = "/main";
  static const String loginWebView = "/login/webview";
  static const String inputFormRoot = "/form";
  static const String chatRoomListRoot = "/chat/room";
  static const String groupDetailRoot = "/group/detail";
  static const String chatPage = "/chat/page";
  static const String groupCreateDialog = "/group/create";
  static const String groupRequestRoot = "/group/request";
  static const String boardDetailRoot = "/board/detail";
  static const String postPageRoot = "/board/post";
  static const String postWritePage = "/post/write";

  static List<GetPage> pages =[
    GetPage(name: intialRoot , page : ()=> const InitialPage(), binding: MainBind()),
    GetPage(name: loginRoot, page: ()=> LoginPage()),
    GetPage(name: mainRoot, page: ()=>  MainPage() ,binding: MainBind()),
    GetPage(name: loginWebView, page: ()=> LoginWebView()),
    GetPage(name: inputFormRoot, page: ()=> FormPage()),
    GetPage(name: chatRoomListRoot, page: ()=> ChatRoomListPage(), binding: MainBind()),
    GetPage(name: groupDetailRoot, page: () => GroupDetailPage(groupId: Get.arguments), binding: MainBind(),),
    GetPage(name: chatPage , page:()=> ChatPage(chatRoom: Get.arguments), binding: MainBind()),
    GetPage(name: groupCreateDialog, page: ()=> CreateGroupDialog(), binding: MainBind()),
    GetPage(name: groupRequestRoot, page: ()=> GroupRequestPage(),binding: MainBind()),
    GetPage(name: boardDetailRoot, page: ()=> BoardDetailsPage(
      boardId: Get.arguments['boardId'],
      title: Get.arguments['title'],
    ), binding: MainBind()),
    GetPage(name: postPageRoot , page: ()=> PostPage(
      detail: Get.arguments,
    ),
    binding: MainBind()),
    GetPage(name: postWritePage, page: ()=>WritePostPage(),)

  ];
}