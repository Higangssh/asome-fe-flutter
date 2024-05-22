import 'package:asome/ui/bar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../controller/form_controller.dart';

class FormPage extends StatelessWidget {
  final FormController formController = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    final buttonWidth = 100.0; // 버튼의 가로 크기
    final buttonHeight = 40.0; // 버튼의 세로 크기

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
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child:  TextFormField(
                      onChanged: (value) => formController.nickname.value = value,
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
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: SizedBox(
                          width: buttonWidth,
                          height: buttonHeight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              onPressed: formController.checkNickname,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor("#A3FFD6"),
                              ),
                              child: const FittedBox(
                                fit: BoxFit.scaleDown, // 텍스트 크기를 줄여서 버튼에 맞게 합니다.
                                child: Text(
                                  '중복 확인',
                                  style: TextStyle(fontSize: 16,), // 기본 폰트 크기를 설정합니다.
                                ),
                              ),
                            ),
                          ),
                          ),
                        ),
                      ),
                    ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      onChanged: (value) => formController.school.value = value,
                      decoration: InputDecoration(
                        labelText: '학교인증',
                        hintText: '학교를 입력하세요',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
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
                              style: ElevatedButton.styleFrom(backgroundColor: HexColor("#A3FFD6")),
                              child:  const FittedBox(
                                fit: BoxFit.scaleDown, // 텍스트 크기를 줄여서 버튼에 맞게 합니다.
                                child: Text(
                                  '학교 검색',
                                  style: TextStyle(fontSize: 16), // 기본 폰트 크기를 설정합니다.
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
                      onChanged: (value) => formController.department.value = value,
                      decoration: InputDecoration(
                        labelText: '학과',
                        hintText: formController.school.value,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: SizedBox(
                          width: buttonWidth,
                          height: buttonHeight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              onPressed: formController.searchDepartment,
                              style: ElevatedButton.styleFrom(backgroundColor: HexColor("#A3FFD6")),
                              child:  const FittedBox(
                                fit: BoxFit.scaleDown, // 텍스트 크기를 줄여서 버튼에 맞게 합니다.
                                child: Text(
                                  '학과 검색',
                                  style: TextStyle(fontSize: 16), // 기본 폰트 크기를 설정합니다.
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),),
                  Obx(() => Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      onChanged: (value) => formController.birthdate.value = value,
                      decoration: InputDecoration(
                        labelText: '생년월일',
                        hintText: formController.school.value,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: SizedBox(
                          width: buttonWidth,
                          height: buttonHeight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              onPressed: formController.searchBirthdate,
                              style: ElevatedButton.styleFrom(backgroundColor: HexColor("#A3FFD6")),
                              child: const FittedBox(
                                fit: BoxFit.scaleDown, // 텍스트 크기를 줄여서 버튼에 맞게 합니다.
                                child: Text(
                                  '생년 월일',
                                  style: TextStyle(fontSize: 16), // 기본 폰트 크기를 설정합니다.
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),),
                  SizedBox(height: 32),
                  SizedBox(
                    width: buttonWidth,
                    height: buttonHeight,
                    child: ElevatedButton(
                      onPressed: formController.submitForm,
                      style: ElevatedButton.styleFrom(backgroundColor: HexColor("#A3FFD6")),
                      child: Text('제출'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}