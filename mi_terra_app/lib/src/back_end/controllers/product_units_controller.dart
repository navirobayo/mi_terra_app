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
      await UserRepository.instance.saveUnitsQuantity(unitData);
      Get.snackbar('Hecho.', 'Nuevo gasto añadido');
    } catch (error) {
      print('Error creating expense: $error');
      Get.snackbar('Ups', 'No se ha podido guardar el gasto: $error');
    }
  }
}
