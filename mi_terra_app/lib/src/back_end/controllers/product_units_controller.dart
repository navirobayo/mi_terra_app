import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/user_repository.dart';

class ProductUnitsController extends GetxController {
  static ProductUnitsController get instance => Get.find();

  TextEditingController productQuantity = TextEditingController();

  Future<void> addUnit(Map<String, dynamic> productData) async {
    final double productQuantityValue = double.parse(productQuantity.text);
    final String productId = productData['product_id'];

    final Map<String, dynamic> unitData = {
      'unit_quantity': productQuantityValue,
      'product_id': productId,
    };

    try {
      // Update available quantity in the user's document
      await UserRepository.instance.saveUnitsQuantity(unitData);

      // Check if available quantity is greater than 0 to create the publicProductObject
      if (productQuantityValue > 0) {
        // Create a copy of the product in the "store" collection
        await UserRepository.instance.createPublicProductObject(productData);
      }

      Get.snackbar('Hecho.', 'Productos disponibles actualizados');
    } catch (error) {
      print('Error creating expense: $error');
      Get.snackbar('Ups', 'No se ha podido guardar la información: $error');
    }
  }
}
