import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  var nickname = ''.obs;
  var school = ''.obs;
  var department = ''.obs;
  var birthdate = ''.obs;

  final formKey = GlobalKey<FormState>();

  void checkNickname() {
    // Handle 중복확인 action
  }

  void searchSchool() {
    // Handle 학교인증 검색 action
  }

  void searchDepartment() {
    // Handle 학과 검색 action
  }

  void searchBirthdate() {
    // Handle 생년월일 검색 action
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      // Handle form submission
    }
  }
}