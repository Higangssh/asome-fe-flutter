import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../controller/board_detail_controller.dart';
import '../../controller/post_controller.dart';
import '../../model/dto/board_detail_list_dto.dart';
import 'comment_item_page.dart';

class PostPage extends StatelessWidget {
  final BoardDetailsDto detail;
  late final PostController postController;
  late final BoardDetailsController boardDetailsController;

  PostPage({required this.detail}) {
    postController = Get.put(PostController(detail.postId));
    boardDetailsController = Get.find<BoardDetailsController>();
    postController.isLiked.value = detail.isLiked;
    postController.likeCount.value = detail.likeCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("게시글 상세"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                              "${detail.viewCount + 1}명이 봤어요",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(height: 20),
                        Obx(() {
                          return Row(
                            children: [
                              OutlinedButton.icon(
                                onPressed: () {
                                  boardDetailsController.toggleLike(detail.postId);
                                  postController.changeCountAndIsLiked();
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.thumbsUp,
                                  color: Colors.orange, // 아이콘 색상 변경
                                  size: 20,
                                ),
                                label: Obx(() => Text(
                                  postController.likeCount.toString(), // 공감 수를 텍스트로 표시
                                  style: TextStyle(color: Colors.grey),
                                )),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: postController.isLiked.value ? Colors.orange : Colors.grey, // 테두리 색상 변경
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Obx(() {
                                return OutlinedButton(
                                  onPressed: () {
                                    postController.toggleScrap();
                                  },
                                  child: Text(
                                    postController.isScrap.value ? "저장됨" : "저장",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: postController.isScrap.value ? Colors.orange : Colors.grey, // 테두리 색상 변경
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          );
                        }),
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
                                return CommentItem(
                                  comment: postController.comments[index],
                                  isReply: false,
                                  controller: postController, // Pass the controller
                                );
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: postController.commentController,
                    focusNode: postController.replyFocusNode,
                    decoration: InputDecoration(
                      hintText: '댓글을 입력하세요...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    if (postController.commentController.text.isNotEmpty) {
                      await postController.addComment(postController.commentController.text);
                      postController.commentController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}






