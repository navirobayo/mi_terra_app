import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/user_repository.dart';
import 'package:uuid/uuid.dart';

class GeneralExpenseController extends GetxController {
  static GeneralExpenseController get instance => Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController expenseQuantity = TextEditingController();
  TextEditingController expensePricePerUnit = TextEditingController();
  TextEditingController expenseItemName = TextEditingController();

  Future<void> createGeneralExpense() async {
    final double expenseQuantityValue = double.parse(expenseQuantity.text);
    final double expensePricePerUnitValue =
        double.parse(expensePricePerUnit.text);
    final double totalExpense = expenseQuantityValue * expensePricePerUnitValue;
    final DateTime expenseDate = DateTime.now();
    final String generalExpenseId = const Uuid().v4();

    final Map<String, dynamic> generalExpenseData = {
      'general_expense_quantity': expenseQuantityValue,
      'general_expense_name': expenseItemName.text,
      'general_expense_price_per_unit': expensePricePerUnitValue,
      'general_expense_date': expenseDate,
      'total_spent': totalExpense,
      'general_expense_id': generalExpenseId
    };

    try {
      await UserRepository.instance.saveGeneralExpense(generalExpenseData);
      Get.snackbar('Hecho.', 'Nuevo gasto general añadido');
    } catch (error) {
      print('Error creating expense: $error');
      Get.snackbar('Ups', 'No se ha podido guardar el gasto: $error');
    }
  }
}
