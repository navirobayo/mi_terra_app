import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/user_repository.dart';

class SaleController extends GetxController {
  static SaleController get instance => Get.find();

  TextEditingController productQuantity = TextEditingController();
  TextEditingController productCommentary = TextEditingController();

  Future<void> createSale(Map<String, dynamic> productData) async {
    final double productQuantityValue = double.parse(productQuantity.text);
    final double productPricePerUnit = productData['product_price']
        as double; // Assuming product_price is of type double
    final double totalSale = productQuantityValue * productPricePerUnit;
    final String productId =
        productData['product_id']; // Assuming product_id is of type String
    final DateTime saleDate = DateTime.now();

    final Map<String, dynamic> saleData = {
      'product_quantity': productQuantityValue,
      'product_commentary': productCommentary.text,
      'product_price_per_unit': productPricePerUnit,
      'sale_date': saleDate,
      'total_sale': totalSale,
      'product_id': productId,
    };

    try {
      await UserRepository.instance.saveSale(saleData);
      // You can add a snackbar here to confirm the creation of the new sale.
      Get.snackbar('Success', 'Sale created successfully');
    } catch (error) {
      print('Error creating sale: $error');
      // Handle the error or show an error message.
      Get.snackbar('Error', 'Failed to create sale: $error');
    }
  }
}
