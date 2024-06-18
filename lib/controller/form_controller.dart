import 'package:asome/model/dto/member_dto.dart';
import 'package:asome/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:asome/service/api_form_service.dart';
import 'package:intl/intl.dart';

class FormController extends GetxController {
  var nickname = ''.obs;
  var schoolName = ''.obs;
  var schoolEmail = ''.obs;
  var emailCode = ''.obs;
  var birthdate = ''.obs;
  var gender = [true, false].obs;
  var nickBaseColor = HexColor("#00E8C1").obs;
  var schoolNameBaseColor = HexColor("#00E8C1").obs;
  var schoolEmailBaseColor = HexColor("#00E8C1").obs;
  var schoolCodeBaseColor = HexColor("#00E8C1").obs;
  var birthdayBaseColor = HexColor("#00E8C1").obs;
  final formKey = GlobalKey<FormState>();
  final nicknameStatusMessage = '중복 확인'.obs;
  final schoolNameStatusMessage = '학교 인증'.obs;
  final schoolEmailStatusMessage = '메일 인증'.obs;
  final schoolCodeStatusMessage = '코드 인증'.obs;
  final birthdayStatusMessage ="생년 월일".obs;
  final isSchoolExist = false.obs;
  final isNickNameAvailable = false.obs;
  final isSchoolNameAvailable =false.obs;
  final isCodeAvailable =false.obs;
  final isSendEmailSuccess = false.obs;
  final isBirthDayAvailable = false.obs;
  final birthdateController = TextEditingController().obs;

  final ApiFormService apiFormService = ApiFormService();

  @override
  void onClose() {
    birthdateController.value.dispose();
    super.onClose();
  }


  void selectGender(int index){
    for (int i = 0; i < gender.length; i++) {
      gender[i] = i == index;
    }
  }

  void checkNickname() async {
    bool isNickExist = await apiFormService.checkNicknameApi(nickname.value);
    //이용 가능한 경우
    if (!isNickExist) {
      nicknameStatusMessage.value = "사용 가능";
      nickBaseColor.value = HexColor("7DC4FF"); //green 계열
      isNickNameAvailable.value = true;
    } else {
      nicknameStatusMessage.value = "이미 사용 중";
      nickBaseColor.value = HexColor("FF8FCA"); //red 계열
      isNickNameAvailable.value = false;
    }
  }
  String? validateNickname(String? value) {
    if (!isNickNameAvailable.value) {
      return '이미 사용 중인 닉네임입니다';
    }
    return null; // null을 반환하면 검증 통과
  }

  void searchSchool() async{
    bool isSuccess = await apiFormService.searchSchoolNameApi(schoolName.value);
    if(isSuccess){
      schoolNameStatusMessage.value = "인증 완료";
      schoolNameBaseColor.value = HexColor("7DC4FF"); //green 계열
      isSchoolNameAvailable.value = true;
    }else{
      schoolNameStatusMessage.value = "유효 하지 않음";
      schoolNameBaseColor.value = HexColor("FF8FCA");
      isSchoolNameAvailable.value = false;
    }
  }

  String? validateSchoolName(String? value) {
    if(!isSchoolNameAvailable.value){
      return "유효 하지 않은 학교 이름 입니다";
    }
    return null; // null을 반환하면 검증 통과
  }


  void sendEmail() async{
    bool isSuccess = await apiFormService.sendSchoolEmail(schoolName.value, schoolEmail.value);
    if(isSuccess){
      schoolEmailStatusMessage.value = "전송 완료";
      schoolEmailBaseColor.value= HexColor("7DC4FF");
      isSendEmailSuccess.value= true;
    }else{
      schoolEmailStatusMessage.value = "전송 실패";
      schoolEmailBaseColor.value= HexColor("FF8FCA");
      isSendEmailSuccess.value= false;
    }

  }


  String? validateSendEmail(String? value) {
    if(!isSendEmailSuccess.value){
      return "학교 이름 혹은 메일 주소를 다시 확인해주세요";
    }
    return null; // null을 반환하면 검증 통과
  }

  void checkEmailCode() async{
    bool isSuccess = await apiFormService.verifyEmailCode(schoolName.value, schoolEmail.value, emailCode.value);
    if(isSuccess){
      schoolCodeStatusMessage.value = "인증 완료";
      schoolCodeBaseColor.value= HexColor("7DC4FF");
      isCodeAvailable.value= true;
    }else{
      schoolCodeStatusMessage.value = "전송 실패";
      schoolCodeBaseColor.value= HexColor("FF8FCA");
      isCodeAvailable.value= false;
    }

  }

  String? validateEmailCode(String? value) {
    if(!isCodeAvailable.value){
      return "학교 이름 혹은 메일 주소 혹은 인증코드를 다시 확인 하세요";
    }
    return null; // null을 반환하면 검증 통과
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy/MM/dd').format(pickedDate);
      birthdate.value = formattedDate;
      print("여기");
      birthdateController.value.text = "${pickedDate.year}년 ${pickedDate.month}월 ${pickedDate.day}일";
      birthdayStatusMessage.value = "선택 완료";
      birthdayBaseColor.value = HexColor("7DC4FF");
      isBirthDayAvailable.value =true;
    }
  }

  String? validateBirthDay(String? value) {
    if(!isBirthDayAvailable.value){
      return "생년 월일을 선택하세요";
    }
    return null; // null을 반환하면 검증 통과
  }


  void submitForm() async{
    if (formKey.currentState!.validate()) {
      MemberDto dto = MemberDto(
        nick : nickname.value,
        universityEmail: schoolEmail.value,
        birth:  DateTime.parse(birthdate.value.replaceAll('/', '-')),
        universityName: schoolName.value,
        gender:  gender[0] ? '남자' : '여자'
      );
      await apiFormService.submitEssentialInfoAndGetNewAccessToken(dto);
      Get.offAllNamed(MainRoute.mainRoot);

    }else{
      showValidationDialog();
    }
  }

  void showValidationDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('인증 실패',
          textAlign: TextAlign.center,),
        content: const Text('인증이 완료되지 않았습니다.'),
        actions: <Widget>[
          Center(
            child: TextButton(
              child: const Text('확인'),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }

  void showOptionalInputDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('알림',
          textAlign: TextAlign.center, ),
        content: const Text(
          '사용에 제한이 있을 수 있습니다.',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,),
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        actions: <Widget>[
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: const Text('지금 입력'),
                  onPressed: () {
                    // 지금 입력 버튼 클릭 시 처리할 작업
                    Get.back(); // 다이얼로그 닫기
                  },
                ),
                TextButton(
                  child: const Text('다음에 입력'),
                  onPressed: () {
                    // 다음에 입력 버튼 클릭 시 처리할 작업
                    Get.back(); // 다이얼로그 닫기
                    Get.offNamed(MainRoute.mainRoot); // '다음에 입력' 페이지로 이동
                  },
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}