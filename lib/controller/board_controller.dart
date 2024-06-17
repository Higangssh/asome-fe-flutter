import 'package:asome/controller/url_token_controller.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/dto/board_list_dto.dart';

class BoardListController extends GetxController {
  var boardList = <BoardListDto>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  late UrlTokenController urlTokenController;

  @override
  void onInit() {
    super.onInit();
    urlTokenController=Get.find<UrlTokenController>();
  }

  Future<void> fetchBoardList() async {
    try {
      isLoading(true);
      final String url = "${urlTokenController.url.value}/api/board/list";
      var headers = urlTokenController.createHeaders();
      final response = await http.get(Uri.parse(url), headers: headers);


      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        boardList.value = jsonResponse.map((data) => BoardListDto.fromJson(data)).toList();
      } else {
        print(response.statusCode);
        errorMessage('게시판 조회에 실패 했습니다');
      }
    } catch (e) {
      errorMessage('게시판 조회에 실패 했습니다');
    } finally {
      isLoading(false);
    }
  }
}
