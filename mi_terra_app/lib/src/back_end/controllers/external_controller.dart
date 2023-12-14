import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/user_repository.dart';
import 'package:uuid/uuid.dart';

class ExternalController extends GetxController {
  static ExternalController get instance => Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController expenseQuantity = TextEditingController();
  TextEditingController expensePricePerUnit = TextEditingController();
  TextEditingController expenseItemName = TextEditingController();

  Future<void> createExpense(Map<String, dynamic> productData) async {
    final double expenseQuantityValue = double.parse(expenseQuantity.text);
    final double expensePricePerUnitValue =
        double.parse(expensePricePerUnit.text);
    final double totalExpense = expenseQuantityValue * expensePricePerUnitValue;
    final String productId = productData['product_id'];
    final DateTime expenseDate = DateTime.now();
    final String expenseId = const Uuid().v4();

    final Map<String, dynamic> expenseData = {
      'expense_quantity': expenseQuantityValue,
      'expense_name': expenseItemName.text,
      'expense_price_per_unit': expensePricePerUnitValue,
      'expense_date': expenseDate,
      'total_spent': totalExpense,
      'product_id': productId,
      'expense_id': expenseId
    };

    try {
      await UserRepository.instance.saveExpense(expenseData);
      Get.snackbar('Hecho.', 'Nuevo gasto añadido');
    } catch (error) {
      print('Error creating expense: $error');
      Get.snackbar('Ups', 'No se ha podido guardar el gasto: $error');
    }
  }
}
