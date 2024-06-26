import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../model/dto/comment_dto.dart';
import '../../controller/post_controller.dart';

class CommentItem extends StatefulWidget {
  final CommentDto comment;
  final bool isReply;
  final PostController controller; // Add controller to the widget

  CommentItem({required this.comment, required this.isReply, required this.controller});

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool showReplies = false;
  final FocusNode replyFocusNode = FocusNode(); // FocusNode for the reply text field

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
                backgroundImage: AssetImage('assets/default_avatar.png'),
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
                          widget.comment.timeAgoSinceDate(widget.comment.createDate),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(widget.comment.content),
                    if (widget.isReply) SizedBox(height: 8),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(0),
                          child: FaIcon(
                            FontAwesomeIcons.thumbsUp,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "좋아요  ${widget.comment.likeCount.toString()}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        if (!widget.isReply)
                          Row(
                            children: [
                              SizedBox(width: 3),
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
                              TextButton(
                                onPressed: () {
                                  widget.controller.setParentIdAndFocus(widget.comment.id);
                                },
                                child: Text(
                                  "답글 쓰기",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.more_vert, color: Colors.grey),
                onPressed: () {
                  // Handle more options
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
                  .map((child) => CommentItem(comment: child, isReply: true, controller: widget.controller))
                  .toList(),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    replyFocusNode.dispose(); // Dispose FocusNode
    super.dispose();
  }
}



