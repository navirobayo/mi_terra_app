import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final terraEmail = TextEditingController();
  final terraPassword = TextEditingController();
  final terraUser = TextEditingController();

  void loginUser(String terraEmail, String terraPassword) {
    AuthenticationRepository.instance
        .loginWithEmailAndPassword(terraEmail, terraPassword);
  }
}
