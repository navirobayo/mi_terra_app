import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/authentication_repository.dart';

class RegistrationController extends GetxController {
  static RegistrationController get instance => Get.find();

  final terraEmail = TextEditingController();
  final terraPassword = TextEditingController();
  final terraUser = TextEditingController();

  void registerUser(String terraEmail, String terraPassword) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(terraEmail, terraPassword);
  }
}
