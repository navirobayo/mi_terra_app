import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/authentication_repository.dart';
import 'package:mi_terra_app/src/back_end/repositories/user_repository.dart';

class RegistrationController extends GetxController {
  static RegistrationController get instance => Get.find();

  final formKey = GlobalKey<FormState>();

  final terraEmail = TextEditingController();
  final terraPassword = TextEditingController();
  final terraUsername = TextEditingController();

  void registerUser(String terraEmail, String terraPassword) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(terraEmail, terraPassword)
        .then((_) {
      createUserDocument();
    }).catchError((error) {
      print("error: $error");
    });
  }

  void createUserDocument() {
    final Map<String, dynamic> userDocument = {
      "global_data": {"global_spent_net_value": 0, "global_profits": 0},
      "contacts": [],
      "tasks": {"to_do": [], "completed": []},
      "inventory": {"in_use": [], "not_used": []},
      "products": [],
      "catalog": [],
      "profile": {
        "user_bio:": "Cuéntanos más sobre ti o sobre tu empresa",
        "user_location": "Sin dirección física",
        "user_name": terraUsername.text,
        "user_phone": "No Teléfono",
        "user_social_media_01": "Tu red social de preferencia",
        "user_social_media_01_title": "",
        "user_social_media_02": "",
        "user_social_media_02_title": ""
      }
    };

    UserRepository.instance.createUserInDataBase(userDocument);
  }
}
