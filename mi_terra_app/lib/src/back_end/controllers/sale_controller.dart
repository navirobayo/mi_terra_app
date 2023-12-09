import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/user_repository.dart';
import 'package:uuid/uuid.dart';

class SaleController extends GetxController {
  static SaleController get instance => Get.find();

  TextEditingController productQuantity = TextEditingController();
  TextEditingController productCommentary = TextEditingController();

  Future<void> createSale(Map<String, dynamic> productData) async {
    final double productQuantityValue = double.parse(productQuantity.text);
    final double productPricePerUnit = productData['product_price'] as double;
    final double totalSale = productQuantityValue * productPricePerUnit;
    final String productId = productData['product_id'];
    final DateTime saleDate = DateTime.now();
    final String saleId = const Uuid().v4();

    final Map<String, dynamic> saleData = {
      'product_quantity': productQuantityValue,
      'product_commentary': productCommentary.text,
      'product_price_per_unit': productPricePerUnit,
      'sale_date': saleDate,
      'total_sale': totalSale,
      'product_id': productId,
      'sale_id': saleId
    };

    try {
      await UserRepository.instance.saveSale(saleData);
      Get.snackbar('Felicidades!', 'Nueva venta añadida');
    } catch (error) {
      print('Error creating sale: $error');
      Get.snackbar('Ups', 'No se ha podido guardar la venta: $error');
    }
  }
}
