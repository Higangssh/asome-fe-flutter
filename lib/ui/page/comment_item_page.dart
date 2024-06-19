import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../model/dto/comment_dto.dart';

class CommentItem extends StatefulWidget {
  final CommentDto comment;

  CommentItem({required this.comment});

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool showReplies = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/default_avatar.png'), // 기본 이미지
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.comment.nickname,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(
                          widget.comment.createDate,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(widget.comment.content),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(0), // 패딩 제거
                          child: FaIcon(
                            FontAwesomeIcons.thumbsUp,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 4), // 아이콘과 텍스트 사이 간격 조정
                        Text(
                          "좋아요  ${widget.comment.likeCount.toString()}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              showReplies = !showReplies;
                            });
                          },
                          child: Text(
                            "답글  ${widget.comment.replyCount}",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.more_vert, color: Colors.grey),
                onPressed: () {
                  // 더보기 클릭 이벤트 처리
                },
              ),
            ],
          ),
        ),
        if (showReplies && widget.comment.children.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Column(
              children: widget.comment.children
                  .map((child) => CommentItem(comment: child))
                  .toList(),
            ),
          ),
      ],
    );
  }
}