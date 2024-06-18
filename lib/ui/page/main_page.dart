import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../controller/board_controller.dart';
import '../../controller/group_controller.dart';
import '../../controller/message_controller.dart';
import '../../route/main_route.dart';
import '../bar/custom_appbar.dart';
import '../bar/custom_bottombar.dart';
import '../dialog/create_group_dialog.dart';
import '../dialog/group_list_dialog.dart';
import '../../model/dto/group_dto.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GroupController controller = Get.find<GroupController>();
  final MessageController messageController = Get.put(MessageController());
  final BoardListController boardListController = Get.find<BoardListController>();

  @override
  void initState() {
    super.initState();
    controller.getInvitedGroupList(); // 페이지 초기화 시 그룹 리스트를 가져옵니다.
    boardListController.fetchBoardList();
  }

  @override
  void dispose() {
    Get.delete<MessageController>(); // MessageController를 삭제하여 메모리 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(themeData: Theme.of(context)),
      bottomNavigationBar: CustomBottomBar(),
      body: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.notifications, color: HexColor("#00E8C1")),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Obx(() {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return FadeTransition(opacity: animation, child: child);
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                messageController.currentMessage,
                                key: ValueKey<String>(messageController.currentMessage),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildGridItem(Icons.favorite, '매칭', '그룹과 매칭하세요', () {
                  // 매칭 버튼 클릭 시 동작 정의
                  print("매칭 버튼 클릭됨");
                }),
                const SizedBox(height: 10),
                _buildGridItem(Icons.group_add, '그룹 만들기', '새로운 그룹을 만드세요', () {
                  // 그룹 만들기 버튼 클릭 시 동작 정의
                  showCreateGroupDialog(context);
                }),
                const SizedBox(height: 10),
                _buildGridItem(Icons.group, '그룹 조회', '기존 그룹을 조회하세요', () async {
                  List<GroupDto> groupList = await controller.getListGroup();
                  showGroupListDialog(context, groupList);
                }),
                const SizedBox(height: 10),
                _buildGridItem(Icons.support_agent, '고객센터', '문의사항을 남기세요', () {
                  // 고객센터 버튼 클릭 시 동작 정의
                  print("고객센터 버튼 클릭됨");
                }),
                const SizedBox(height: 20),
                _buildBoardSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Icon(icon, color: HexColor("#00E8C1"), size: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildBoardSection() {
    return Obx(() {
      if (boardListController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else if (boardListController.errorMessage.isNotEmpty) {
        return Center(child: Text(boardListController.errorMessage.value));
      } else if (boardListController.boardList.isEmpty) {
        return Center(child: Text('게시판 조회에 실패했습니다'));
      } else {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '즐겨찾는 게시판',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(color: Colors.grey),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: boardListController.boardList.length,
                itemBuilder: (context, index) {
                  final boardItem = boardListController.boardList[index];
                  return InkWell(
                    onTap: () {
                      // 게시판 아이템 클릭 시 동작 정의
                      print("게시판 아이템 클릭됨: ID = ${boardItem.id}");
                      Get.toNamed(MainRoute.boardDetailRoot,  arguments: {
                        'boardId': boardItem.id,
                        'title': boardItem.title,
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                      child: Row(
                        children: [
                          Text(
                            boardItem.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              boardItem.lastPostTitle,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }
    });
  }

  void showGroupListDialog(BuildContext context, List<GroupDto> groups) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GroupListDialog(groups: groups);
      },
    );
  }

  void showCreateGroupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '그룹 생성',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(width: 10),
              Icon(Icons.group_add, color: HexColor("#00E8C1")),
            ],
          ),
          content: CreateGroupDialog(),
        );
      },
    ).then((_) {});
  }
}

