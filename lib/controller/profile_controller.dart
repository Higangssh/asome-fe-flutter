import 'package:asome/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/dto/board_detail_list_dto.dart';
import '../model/dto/profile_dto.dart';
import '../service/api_profile_service.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var profile = ProfileResponseDto(nick: '',
      email: '',
      universityEmail: '',
      universityName: '',
      profile: '').obs;
  var apiService = ApiProfileService();
  var myPosts = <BoardDetailsDto>[].obs; // 추가
  var myScraps = <BoardDetailsDto>[].obs; // 추가

  @override
  void onInit() {
    fetchProfile();
    super.onInit();
  }

  void fetchProfile() async {
    try {
      isLoading(true);
      ProfileResponseDto profileData = await apiService.fetchProfile();
      profile.value = profileData;
    } catch (e) {
      print('프로필 로드 에러: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchMyPosts() async {
    try {
      isLoading(true);
      List<BoardDetailsDto> postData = await apiService.fetchMyPosts(0);
      myPosts.assignAll(postData);
    } catch (e) {
      print('내가 쓴 글 로드 에러: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchMyScraps() async {
    try {
      isLoading(true);
      List<BoardDetailsDto> scrapData = await apiService.fetchMyScraps(0);
      myScraps.assignAll(scrapData);
    } catch (e) {
      print('내가 저장한 글 로드 에러: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<bool> fetchLogout() async {
    try{
      return await apiService.fetchLogout();
    }catch(e){
      print("log out exception");
      return false;
    }
  }

  void logoutProcess(bool isSuccess){
      if(isSuccess){
        Get.offAndToNamed(MainRoute.intialRoot);
      }else{
        Get.defaultDialog(
          title: "로그아웃 실패",
          middleText: "실패했습니다",
          textConfirm: "확인",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          },
          buttonColor: Colors.red,
          barrierDismissible: false,
          radius: 10.0,
          content: const Column(
            children: [
              Icon(Icons.error, color: Colors.red, size: 50),
              SizedBox(height: 10),
              Text("로그아웃 중 문제가 발생했습니다."),
            ],
          ),
        );
      }
  }
}
