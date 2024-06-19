import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/dto/comment_dto.dart';
import '../service/api_comment_service.dart';

class PostController extends GetxController {
  var comments = <CommentDto>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  late final ApiCommentService apiCommentService;
  final int postId; // postId를 멤버 변수로 선언

  PostController(this.postId); // 생성자에서 postId를 받아서 초기화

  @override
  void onInit() {
    apiCommentService = ApiCommentService();
    fetchComments(postId, 0); // postId를 사용하여 fetchComments 호출
    super.onInit();
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
}

