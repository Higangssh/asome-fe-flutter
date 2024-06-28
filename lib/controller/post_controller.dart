
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';

import '../model/dto/category_dto.dart';
import '../model/dto/comment_dto.dart';
import '../service/api_comment_service.dart';

class PostController extends GetxController {
  var comments = <CommentDto>[].obs;
  var categories = <CategoryDto>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var likeCount = 0.obs;
  var isLiked = false.obs;
  var isScrap = false.obs;
  var parentId = Rxn<int>(); // Added to keep track of the parent comment ID
  late final ApiBoardService apiCommentService;
  final int postId;
  TextEditingController commentController = TextEditingController(); // Added TextEditingController
  FocusNode replyFocusNode = FocusNode(); // Added FocusNode

  PostController(this.postId);

  @override
  void onInit() {
    apiCommentService = ApiBoardService();
    fetchComments(postId, 0);
    super.onInit();
  }

  @override
  void dispose() {
    commentController.dispose(); // Dispose TextEditingController
    replyFocusNode.dispose(); // Dispose FocusNode
    super.dispose();
  }

  void fetchComments(int postId, int pageNum) async {
    try {
      isLoading(true);
      var commentsData = await apiCommentService.fetchComments(postId, pageNum);
      comments.value = commentsData;
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void changeCountAndIsLiked() {
    if (isLiked.value) {
      isLiked.value = false;
      likeCount.value--;
    } else {
      isLiked.value = true;
      likeCount.value++;
    }
  }

  Future<void> addComment(String content) async {
    try {
      isLoading(true);
      var newComment = await apiCommentService.addComment(postId, content, parentId.value);
      if (parentId.value != null) {
        // Add as a reply to the parent comment
        var parentComment = comments.firstWhere((comment) => comment.id == parentId.value);
        parentComment.children.add(newComment);
        parentComment.replyCount++;
      } else {
        // Add as a top-level comment
        comments.add(newComment);
      }
      commentController.clear(); // Clear the text field after adding comment
      parentId.value = null; // Reset parentId after adding comment
      isLoading(false);
    } catch (e) {
      errorMessage(e.toString());
      isLoading(false);
    }
  }

  void setParentIdAndFocus(int? id) {
    parentId.value = id;
    commentController.text = ''; // Clear the text field
    Future.delayed(Duration(milliseconds: 100), () {
      replyFocusNode.requestFocus(); // Request focus on the text field
    });
  }

  Future<void> toggleScrap() async {
    try {
      isLoading(true);
      final response = await apiCommentService.toggleScrap(postId);
      if (response) {
        isScrap.value = !isScrap.value;
      } else {
        throw Exception('Failed to toggle scrap');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
