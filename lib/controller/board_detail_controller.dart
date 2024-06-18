import 'package:get/get.dart';
import 'package:asome/service/api_post_service.dart';
import '../model/dto/board_detail_list_dto.dart';

class BoardDetailsController extends GetxController {
  var boardDetailsList = <BoardDetailsDto>[].obs;
  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  var isLastPage = false.obs;
  var errorMessage = ''.obs;
  var pageNum = 0.obs;

  final ApiPostService apiPostService = ApiPostService();

  @override
  void onInit() {
    super.onInit();
  }

  void fetchBoardDetails(int id) async {
    try {
      isLoading(true);
      errorMessage(''); // Reset the error message
      isLastPage(false); // Reset last page flag
      pageNum(0); // Reset page number
      var response = await apiPostService.fetchBoardDetails(id);
      boardDetailsList.assignAll(response); // 기존 데이터를 새 데이터로 교체
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshBoardDetails(int id) async {
    try {
      isLoading(true);
      errorMessage(''); // Reset the error message
      isLastPage(false); // Reset last page flag
      pageNum(0); // Reset page number
      var response = await apiPostService.fetchBoardDetails(id);

      // 중복 체크 후 새로운 데이터 추가
      boardDetailsList.clear();
      for (var newDetail in response) {
        if (!boardDetailsList.any((detail) => detail.postId == newDetail.postId)) {
          boardDetailsList.add(newDetail);
        }
      }
      if (response.isEmpty) {
        isLastPage(true);
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void fetchMoreBoardDetails(int id) async {
    if (isLoadingMore.value || isLastPage.value) return; // 이미 로딩 중이거나 마지막 페이지인 경우 중복 요청 방지
    try {
      isLoadingMore(true);
      errorMessage(''); // Reset the error message
      pageNum.value += 1;
      print("Fetching more details for page: ${pageNum.value}");
      var response = await apiPostService.fetchBoardMoreDetails(id, pageNum.value);

      if (response.isEmpty) {
        isLastPage(true);
      } else {
        // 중복 체크 후 새로운 데이터 추가
        for (var newDetail in response) {
          if (!boardDetailsList.any((detail) => detail.postId == newDetail.postId)) {
            boardDetailsList.add(newDetail);
          }
        }
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoadingMore(false);
    }
  }

  void toggleLike(int postId) async {
    try {
      bool likeStatus = await apiPostService.fetchLikeCount(postId);
      int index = boardDetailsList.indexWhere((detail) => detail.postId == postId);
      if (index != -1) {
        BoardDetailsDto detail = boardDetailsList[index];
        detail.likeCount = likeStatus ? detail.likeCount + 1 : detail.likeCount - 1;
        detail.isLiked = likeStatus; // 좋아요 상태 업데이트
        boardDetailsList[index] = detail; // 리스트 갱신
        boardDetailsList.refresh(); // RxList 업데이트
      }
    } catch (e) {
      errorMessage(e.toString());
    }
  }
}



