import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isHidePass = true.obs;
  var isLoading = false.obs;

  late TextEditingController emailC;

  late TextEditingController passC;

  @override
  void onInit() {
    emailC = TextEditingController(text: 'admin@gmail.com');
    passC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }
}
