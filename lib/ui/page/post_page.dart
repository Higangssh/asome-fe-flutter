import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../controller/post_controller.dart';
import '../../model/dto/board_detail_list_dto.dart';
import '../../model/dto/comment_dto.dart';
import 'comment_item_page.dart';

class PostPage extends StatelessWidget {
  final BoardDetailsDto detail;
  late final PostController postController;

  PostPage({required this.detail}) {
    postController = Get.put(PostController(detail.postId)); // postId 전달
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("게시글 상세"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/default_avatar.png'), // 프로필 이미지
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail.nick,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${detail.relativeTime}",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  Text(
                    detail.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    detail.content,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.eye,
                        size: 16,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "${detail.viewCount}명이 봤어요",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          // 공감하기 클릭 이벤트 처리
                          print("공감하기 클릭됨");
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.thumbsUp,
                          color: Colors.orange, // 아이콘 색상은 고정
                          size: 20,
                        ),
                        label: Text(
                          detail.likeCount.toString(), // 공감 수를 텍스트로 표시
                          style: TextStyle(color: Colors.grey),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: detail.isLiked ? Colors.orange : Colors.grey, // 테두리 색상 변경
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      OutlinedButton(
                        onPressed: () {
                          // 저장하기 클릭 이벤트 처리
                          print("저장하기 클릭됨");
                        },
                        child: Text(
                          "저장",
                          style: TextStyle(color: Colors.grey),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 10,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!, width: 1),
                  bottom: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
                color: Color(0xFFF5F5F5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "댓글 ${detail.commentCount}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Obx(() {
                    if (postController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (postController.errorMessage.isNotEmpty) {
                      return Center(child: Text(postController.errorMessage.value));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: postController.comments.length,
                        itemBuilder: (context, index) {
                          return CommentItem(comment: postController.comments[index]);
                        },
                      );
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





