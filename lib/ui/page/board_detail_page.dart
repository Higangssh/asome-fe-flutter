import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../controller/board_detail_controller.dart';

class BoardDetailsPage extends StatefulWidget {
  final int boardId;
  final String title;

  BoardDetailsPage({required this.boardId, required this.title});

  @override
  _BoardDetailsPageState createState() => _BoardDetailsPageState();
}

class _BoardDetailsPageState extends State<BoardDetailsPage> {
  late final BoardDetailsController controller;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(BoardDetailsController());
    _scrollController = ScrollController();

    controller.fetchBoardDetails(widget.boardId);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print("Scrolled to bottom");
        if (!controller.isLoadingMore.value && !controller.isLastPage.value) {
          controller.fetchMoreBoardDetails(widget.boardId);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.boardDetailsList.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.refreshBoardDetails(widget.boardId);
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: controller.boardDetailsList.length + (controller.isLoadingMore.value ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == controller.boardDetailsList.length) {
                  return Center(child: CircularProgressIndicator());
                }

                final detail = controller.boardDetailsList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detail.title,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(detail.content, style: TextStyle(fontSize: 18)),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(detail.nick, style: TextStyle(color: Colors.grey)),
                          SizedBox(width: 10),
                          Text(detail.createDate, style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.toggleLike(detail.postId);
                              },
                              child: Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.thumbsUp,
                                    color: detail.isLiked ? HexColor("#FF0000") : HexColor("#00E8C1"),
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(detail.likeCount.toString()),
                                ],
                              ),
                            ),
                            SizedBox(width: 15), // 아이콘 사이의 간격을 조정합니다
                            GestureDetector(
                              onTap: () {
                                // 댓글 클릭 이벤트 처리
                                print("Commented!");
                                // 여기에 댓글 로직 추가
                              },
                              child: Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.comment, color: HexColor("#00E8C1"), size: 20),
                                  SizedBox(width: 5),
                                  Text(detail.commentCount.toString()),
                                ],
                              ),
                            ),
                            Spacer(), // 남은 공간을 차지하는 빈 공간
                          ],
                        ),
                      ),
                      const Divider(),
                      // _buildCommentsSection(controller),
                    ],
                  ),
                );
              },
            ),
          );
        }
      }),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        width: 120,  // 버튼 너비 조정
        height: 55,  // 버튼 높이 조정
        child: ElevatedButton(
          onPressed: () {
            print("글쓰기 버튼 클릭됨");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: HexColor("#00E8C1"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            padding: EdgeInsets.zero,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.edit, color: Colors.redAccent, size: 18),
              SizedBox(width: 8),
              Text('글 작성', style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}







