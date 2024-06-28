import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../model/dto/board_detail_list_dto.dart';
import '../../route/main_route.dart';

class PostListPage extends StatefulWidget {
  final String title;
  final List<BoardDetailsDto> posts;

  PostListPage({required this.title, required this.posts});

  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print("Scrolled to bottom");
        // 여기에 페이지네이션 로직 추가 가능
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
      body: ListView.builder(
        controller: _scrollController,
        itemCount: widget.posts.length,
        itemBuilder: (context, index) {
          final detail = widget.posts[index];
          return GestureDetector(
            onTap: () {
              Get.toNamed(MainRoute.postPageRoot, arguments: detail);
            },
            child: Container(
              color: Colors.transparent, // 터치 영역을 확장하기 위해 추가
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detail.title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis, // 한 줄 넘어가면 ... 표시
                    maxLines: 1,
                  ),
                  SizedBox(height: 10),
                  Text(
                    detail.content,
                    style: TextStyle(fontSize: 11),
                    overflow: TextOverflow.ellipsis, // 한 줄 넘어가면 ... 표시
                    maxLines: 1,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(detail.nick, style: TextStyle(color: Colors.grey, fontSize: 8)),
                      SizedBox(width: 10),
                      Text(detail.relativeTime, style: TextStyle(color: Colors.grey, fontSize: 8)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // 좋아요 토글 로직 추가
                          },
                          child: Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.thumbsUp,
                                color: detail.isLiked ? Colors.orange : Colors.grey,
                                size: 15,
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
                              FaIcon(
                                  FontAwesomeIcons.comment,
                                  color: detail.commentCount > 0 ? HexColor("#00E8C1") : Colors.grey,
                                  size: 15),
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
            ),
          );
        },
      ),
    );
  }
}