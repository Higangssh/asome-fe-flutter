import 'package:asome/service/api_comment_service.dart';
import 'package:asome/service/api_post_service.dart';
import 'package:get/get.dart';
import '../model/dto/Post_request_dto.dart';
import '../model/dto/category_dto.dart';

class CategoryController extends GetxController {
  var categories = <CategoryDto>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  late final ApiBoardService apiBoardService;

  @override
  void onInit() {
    apiBoardService = ApiBoardService();
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
    try {
      isLoading(true);
      var categoriesData = await apiBoardService.fetchCategories();
      categories.value = categoriesData;
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<bool> addPost(PostRequestDto postRequestDto) async {
    return await apiBoardService.addPost(postRequestDto);
  }
}
