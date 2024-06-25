import 'package:asome/ui/bar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../controller/form_controller.dart';

class FormPage extends StatelessWidget {
  final FormController formController = Get.find<FormController>();


  @override
  Widget build(BuildContext context) {
    const buttonWidth = 100.0; // 버튼의 가로 크기
    const buttonHeight = 40.0; // 버튼의 세로 크기

    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(themeData: Theme.of(context),),
      ),
      body: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 1.0, // 보더의 두께
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formController.formKey,
              child: Column(
                children: [
                  Obx(() => ToggleButtons(
                    isSelected: formController.gender.value,
                    onPressed: (index) {
                      formController.selectGender(index);
                    },
                    borderRadius: BorderRadius.circular(10.0),
                    selectedBorderColor: Colors.black87,
                    selectedColor: Colors.white,
                    fillColor: HexColor("#00E8C1"),
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("남자"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("여자"),
                      ),
                    ],
                  )),
                 const SizedBox(height: 10,),
                 Obx(() => Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child:  TextFormField(
                      onChanged: (value) => formController.nickname.value = value,
                      validator: formController.validateNickname,
                      decoration:  InputDecoration(
                        labelText: '닉네임',
                        hintText: '닉네임을 입력하세요',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(// 포커스 되었을 때의 색상
                            color: Colors.black87,
                            width: 2.0,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: SizedBox(
                          width: buttonWidth,
                          height: buttonHeight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              onPressed: formController.checkNickname,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: formController.nickBaseColor.value,
                              ),
                              child:  FittedBox(
                                fit: BoxFit.scaleDown, // 텍스트 크기를 줄여서 버튼에 맞게 합니다.
                                child: Obx(() => Text(
                                  formController.nicknameStatusMessage.value,
                                  style: const TextStyle(fontSize: 16,color: Colors.white), // 기본 폰트 크기를 설정합니다.
                                ),
                                )
                              ),
                            ),
                          ),
                          ),
                        ),
                      ),
                    ),
                 ),
                  Obx(() => Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      validator: formController.validateSchoolName,
                      onChanged: (value) => formController.schoolName.value = value,
                      decoration: InputDecoration(
                        labelText: '학교명 인증',
                        hintText: '학교를 입력하세요(예: 서울대학교)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(// 포커스 되었을 때의 색상
                            color: Colors.black87,
                            width: 2.0,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: SizedBox(
                          width: buttonWidth,
                          height: buttonHeight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              onPressed: formController.searchSchool,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: formController.schoolNameBaseColor.value),
                              child:  FittedBox(
                                fit: BoxFit.scaleDown, // 텍스트 크기를 줄여서 버튼에 맞게 합니다.
                                child: Obx(() => Text(
                                  formController.schoolNameStatusMessage.value,
                                  style: const TextStyle(fontSize: 16,color: Colors.white), // 기본 폰트 크기를 설정합니다.
                                    ),
                                  )
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(() =>Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      validator: formController.validateSendEmail,
                      onChanged: (value) => formController.schoolEmail.value = value,
                      decoration: InputDecoration(
                        labelText: '학교 이메일 인증',
                        hintText: '학교 이메일을 입력하세요',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(// 포커스 되었을 때의 색상
                            color: Colors.black87,
                            width: 2.0,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: SizedBox(
                          width: buttonWidth,
                          height: buttonHeight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              onPressed: formController.sendEmail,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: formController.schoolEmailBaseColor.value),
                              child:  FittedBox(
                                fit: BoxFit.scaleDown, // 텍스트 크기를 줄여서 버튼에 맞게 합니다.
                                child: Obx(() =>  Text(
                                  formController.schoolEmailStatusMessage.value,
                                  style: const TextStyle(fontSize: 16,color: Colors.white), // 기본 폰트 크기를 설정합니다.
                                ),
                              )
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),),
                  Obx(() =>Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      validator: formController.validateEmailCode,
                      onChanged: (value) => formController.emailCode.value = value,
                      decoration: InputDecoration(
                        labelText: '이메일 발송 코드',
                        hintText: '발송 받은 코드를 입력하세요',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(// 포커스 되었을 때의 색상
                            color: Colors.black87,
                            width: 2.0,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: SizedBox(
                          width: buttonWidth,
                          height: buttonHeight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              onPressed: formController.checkEmailCode,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: formController.schoolCodeBaseColor.value),
                              child:  FittedBox(
                                fit: BoxFit.scaleDown, // 텍스트 크기를 줄여서 버튼에 맞게 합니다.
                                child: Obx(()=>Text(
                                  formController.schoolCodeStatusMessage.value,
                                  style: const TextStyle(fontSize: 16,color: Colors.white), // 기본 폰트 크기를 설정합니다.
                                  ) ,
                                )
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),),
                  Obx(() => Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      controller: formController.birthdateController.value,
                      validator: formController.validateBirthDay,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: '생년월일',
                        hintText: "생년 월일 버튼을 눌러주세요",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(// 포커스 되었을 때의 색상
                            color: Colors.black87,
                            width: 2.0,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: SizedBox(
                          width: buttonWidth,
                          height: buttonHeight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton (
                              onPressed: () => formController.pickDate(context),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: formController.birthdayBaseColor.value),
                              child:  FittedBox(
                                fit: BoxFit.scaleDown, // 텍스트 크기를 줄여서 버튼에 맞게 합니다.
                                child: Obx(()=>Text(
                                  formController.birthdayStatusMessage.value,
                                  style: const TextStyle(fontSize: 16,color: Colors.white), // 기본 폰트 크기를 설정합니다.
                                 ),
                                )
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 32),
                    ],
                  ),
                  SizedBox(
                    width: buttonWidth,
                    height: buttonHeight,
                    child: ElevatedButton(
                      onPressed: formController.submitForm,
                      style: ElevatedButton.styleFrom(backgroundColor: HexColor("#00E8C1")),
                      child: const Text('제출'),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: buttonWidth,
                    height: buttonHeight,
                    child: ElevatedButton(
                      onPressed: formController.showOptionalInputDialog,
                      style: ElevatedButton.styleFrom(backgroundColor: HexColor("#00E8C1")),
                      child: const FittedBox(
                        fit: BoxFit.contain,
                        child: Text('다음에 입력'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}