import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/user_repository.dart';
import 'package:mi_terra_app/src/front_end/inventory_screen/inventory_screen.dart';

class InventoryController extends GetxController {
  static InventoryController get instance => Get.find();

  TextEditingController itemName = TextEditingController();

  RxList<String> pendingItems = <String>[].obs;
  RxList<String> usedItems = <String>[].obs;

  Future<void> createItem() async {
    final String itemNameValue = itemName.text;
    try {
      await UserRepository.instance.saveItem(itemNameValue);
      Get.snackbar('Perfecto', 'Nuevo item añadido al inventario');
    } catch (error) {
      Get.snackbar('Ups', 'No se ha podido guardar este item: $error');
      print("error: $error");
    }
  }

  void moveToUsedItems(int index, String location) {
    final String movedItem = pendingItems[index];
    usedItems.add(movedItem);
    pendingItems.removeAt(index);

    UserRepository.instance.movePendingItem(movedItem, location);
  }

  Future<void> loadNotUsedItems() async {
    try {
      pendingItems.assignAll(await UserRepository.instance.loadNotUsedItems());
    } catch (error) {
      print("Error loading not used items: $error");
    }
  }

  Future<void> loadUsedItems() async {
    try {
      usedItems.assignAll(await UserRepository.instance.loadUsedItems());
    } catch (error) {
      print("Error loading used items: $error");
    }
  }

  void deleteItem(int index, ItemStatus itemStatus) {
    final List<String> itemsToDelete =
        itemStatus == ItemStatus.pending ? pendingItems : usedItems;

    if (index >= 0 && index < itemsToDelete.length) {
      itemsToDelete.removeAt(index);

      final List<String> itemsToUpdate =
          itemStatus == ItemStatus.pending ? usedItems : pendingItems;

      UserRepository.instance.updateItems(
          itemStatus == ItemStatus.pending
              ? 'inventory.not_used'
              : 'inventory.in_use',
          itemsToUpdate);
    }
  }
}
