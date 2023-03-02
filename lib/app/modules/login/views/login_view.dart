import 'package:flutter/material.dart';
import 'package:flutter_qrcode_getx_project/app/controllers/auth_controller.dart';
import 'package:flutter_qrcode_getx_project/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final AuthController authC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.emailC,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => TextField(
              controller: controller.passC,
              autocorrect: false,
              keyboardType: TextInputType.text,
              obscureText: controller.isHidePass.value,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.isHidePass.toggle();
                  },
                  icon: Icon(
                    controller.isHidePass.isTrue
                        ? Icons.remove_red_eye_rounded
                        : Icons.remove_red_eye_outlined,
                    size: 24.0,
                  ),
                ),
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                if (controller.emailC.text.isNotEmpty &&
                    controller.passC.text.isNotEmpty) {
                  controller.isLoading(true);
                  Map<String, dynamic> result = await authC.login(
                      controller.emailC.text, controller.passC.text);
                  controller.isLoading(false);
                  if (result['error'] == true) {
                    Get.snackbar('Error', result['message']);
                  } else {
                    Get.snackbar('Success', result['message']);
                    Get.offAllNamed(Routes.HOME);
                  }
                } else {
                  Get.snackbar('Error', 'Email / Password Can Be Empty');
                }
              }
            },
            child: Obx(
              () => Text(controller.isLoading.isFalse ? "Login" : "Loading..."),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 20),
            ),
          )
        ],
      ),
    );
  }
}
