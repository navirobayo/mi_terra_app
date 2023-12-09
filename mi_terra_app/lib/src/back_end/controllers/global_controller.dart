import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/user_repository.dart';
import 'package:uuid/uuid.dart';

class GlobalControlller extends GetxController {
  static GlobalControlller get instance => Get.find();

  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();

  //! To do: Add snackbar confirming the creation of the new product.

  Future<void> createProduct() async {
    final globalId = const Uuid().v4();
    final globalCreation = DateTime.now();
    final Map<String, dynamic> globalData = {
      'global_id': globalId,
      'global_expenses': 0,
      'global_units': 0,
      'global_creation': globalCreation,
    };
    try {
      await UserRepository.instance.saveProduct(globalData);
    } catch (error) {
      print("error: $error");
    }
  }
}
