import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/user_repository.dart';
import 'package:uuid/uuid.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  TextEditingController productName = TextEditingController();

  //! To do: Add snackbar confirming the creation of the new product.

  Future<void> createProduct() async {
    final productId = const Uuid().v4();
    final Map<String, dynamic> productData = {
      'product_name': productName.text,
      'product_id': productId,
      'product_expenses': 0,
      'product_notes': [],
      'product_profits': 0,
      'product_images': [],
    };
    try {
      await UserRepository.instance.saveProduct(productData);
    } catch (error) {
      print("error: $error");
    }
  }
}
