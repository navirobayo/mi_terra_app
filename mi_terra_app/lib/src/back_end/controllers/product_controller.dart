import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/user_repository.dart';
import 'package:uuid/uuid.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();

  Future<void> createProduct() async {
    final productId = const Uuid().v4();
    final productCreation = DateTime.now();
    final double productPriceValue = double.parse(productPrice.text);
    final Map<String, dynamic> productData = {
      'product_name': productName.text,
      'product_id': productId,
      'product_expenses': [],
      'product_notes': [],
      'product_profits': 0,
      'product_images': [],
      'product_cover':
          "https://firebasestorage.googleapis.com/v0/b/mi-terra-app.appspot.com/o/terra_database%2FCaptura%20de%20pantalla%202023-12-06%20212051.png?alt=media&token=5c031e59-c48e-4b5c-9aeb-6e0b84c3ca08",
      'product_frequency': 0,
      'product_units': 0,
      'products_ready': 0,
      'product_sales': [],
      'product_price': productPriceValue,
      'product_creation': productCreation,
      'product_sales_counter': 0,
      'product_sales_net_value': 0,
      'product_spent_net_value': 0
    };
    try {
      await UserRepository.instance.saveProduct(productData);
      Get.snackbar('Éxito', 'Producto creado');
    } catch (error) {
      Get.snackbar('Error', 'No se ha podido crear el producto: $error');
      print("error: $error");
    }
  }
}
