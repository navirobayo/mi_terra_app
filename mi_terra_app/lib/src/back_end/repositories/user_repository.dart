import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final database = FirebaseFirestore.instance;

  Future<void> createUserInDataBase(Map<String, dynamic> userDocument) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return;
    }
    final userid = user.uid;

    await database.collection("users").doc(userid).set(userDocument).then((_) {
      Get.snackbar("Bienvenido/a!", "Cuenta registrada con éxito",
          snackPosition: SnackPosition.BOTTOM);
    }).catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM);
      print(error.toString());
    });
  }

  Future<void> saveProduct(Map<String, dynamic> productData) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return;
    }
    final userId = user.uid;
    final userDocumentRef = database.collection("users").doc(userId);
    final productId = productData['product_id'];
    try {
      await userDocumentRef.update({
        "products.$productId": productData,
      });
    } catch (error) {
      print("Error saving this product: $error");
      throw error;
    }
  }

  Future<List<Map<String, dynamic>>> getUserProducts() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return [];
    }

    final userId = user.uid;
    final userDocumentRef = database.collection("users").doc(userId);

    final userData = await userDocumentRef.get();
    final products = userData.data()?['products'] ?? {};

    // Convert products map to a list
    List<Map<String, dynamic>> productList = [];
    products.forEach((key, value) {
      productList.add(value);
    });

    return productList;
  }

  Future<void> saveContact(Map<String, dynamic> contactData) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return;
    }
    final userId = user.uid;
    final userDocumentRef = database.collection("users").doc(userId);
    final contactId = contactData['contact_id'];
    try {
      await userDocumentRef.update({
        "contacts.$contactId": contactData,
      });
    } catch (error) {
      print("Error saving this contact: $error");
      throw error;
    }
  }

  Future<List<Map<String, dynamic>>> getUserContacts() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return [];
    }

    final userId = user.uid;
    final userDocumentRef = database.collection("users").doc(userId);

    final userData = await userDocumentRef.get();
    final contacts = userData.data()?['contacts'] ?? {};

    // Convert contacts map to a list
    List<Map<String, dynamic>> contactsList = [];
    contacts.forEach((key, value) {
      contactsList.add(value);
    });

    return contactsList;
  }

  Future<void> saveSale(Map<String, dynamic> saleData) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return;
    }

    final userId = user.uid;
    final userDocumentRef = database.collection("users").doc(userId);
    final productId = saleData['product_id'];
    final saleId = saleData['sale_id'];
    final double totalSale = saleData['total_sale'] as double;

    try {
      await userDocumentRef.update({
        "products.$productId.product_sales.$saleId": saleData,
        "products.$productId.product_sales_counter": FieldValue.increment(1),
        "products.$productId.product_sales_net_value":
            FieldValue.increment(totalSale),
      });
    } catch (error) {
      print("Error guardando esta venta: $error");
      throw error;
    }
  }

  Future<void> saveExpense(Map<String, dynamic> expenseData) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return;
    }

    final userId = user.uid;
    final userDocumentRef = database.collection("users").doc(userId);
    final productId = expenseData['product_id'];
    final saleId = expenseData['expense_id'];
    final double totalSpent = expenseData['total_spent'] as double;

    try {
      await userDocumentRef.update({
        "products.$productId.product_expenses.$saleId": expenseData,
        "products.$productId.product_spent_net_value":
            FieldValue.increment(totalSpent),
      });
    } catch (error) {
      print("Error guardando esta venta: $error");
      throw error;
    }
  }

  Future<void> saveTask(String taskNote) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return;
    }

    final userId = user.uid;
    final userDocumentRef =
        FirebaseFirestore.instance.collection("users").doc(userId);

    try {
      await userDocumentRef.update({
        "tasks.to_do": FieldValue.arrayUnion([taskNote]),
      });
    } catch (error) {
      print("Error saving this task: $error");
      throw error;
    }
  }

  Future<List<String>> loadPendingTasks() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return [];
    }

    final userId = user.uid;
    final userDocumentRef =
        FirebaseFirestore.instance.collection("users").doc(userId);

    try {
      final userData = await userDocumentRef.get();
      final List<dynamic> tasks = userData['tasks.to_do'];
      return tasks.map((task) => task.toString()).toList();
    } catch (error) {
      print("Error loading tasks: $error");
      throw error;
    }
  }

  Future<void> completeTask(String taskNote) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return;
    }

    final userId = user.uid;
    final userDocumentRef =
        FirebaseFirestore.instance.collection("users").doc(userId);

    try {
      await userDocumentRef.update({
        "tasks.to_do": FieldValue.arrayRemove([taskNote]),
        "tasks.completed": FieldValue.arrayUnion([taskNote]),
      });
    } catch (error) {
      print("Error marking task as completed: $error");
      throw error;
    }
  }

  Future<List<String>> loadCompletedTasks() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return [];
    }

    final userId = user.uid;
    final userDocumentRef =
        FirebaseFirestore.instance.collection("users").doc(userId);

    try {
      final userData = await userDocumentRef.get();
      final List<dynamic> tasks = userData['tasks.completed'];
      return tasks.map((task) => task.toString()).toList();
    } catch (error) {
      print("Error loading completed tasks: $error");
      throw error;
    }
  }

  Future<void> updateTasks(String fieldName, List<String> updatedTasks) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return;
    }

    final userId = user.uid;
    final userDocumentRef =
        FirebaseFirestore.instance.collection("users").doc(userId);

    try {
      await userDocumentRef.update({
        fieldName: updatedTasks.map((task) => FieldValue.arrayUnion([task])),
      });
    } catch (error) {
      print("Error updating tasks: $error");
      throw error;
    }
  }

  Future<void> movePendingItem(String movedItem) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return;
    }

    final userId = user.uid;
    final userDocumentRef =
        FirebaseFirestore.instance.collection("users").doc(userId);

    try {
      await userDocumentRef.update({
        "inventory.not_used": FieldValue.arrayRemove([movedItem]),
        "inventory.in_use": FieldValue.arrayUnion([movedItem]),
      });
    } catch (error) {
      print("Error saving inventory item: $error");
      throw error;
    }
  }

  Future<void> saveItem(String itemNameValue) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return;
    }

    final userId = user.uid;
    final userDocumentRef =
        FirebaseFirestore.instance.collection("users").doc(userId);

    try {
      await userDocumentRef.update({
        "inventory.not_used": FieldValue.arrayUnion([itemNameValue]),
      });
    } catch (error) {
      print("Error saving this task: $error");
      throw error;
    }
  }

  Future<List<String>> loadNotUsedItems() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return [];
    }

    final userId = user.uid;
    final userDocumentRef =
        FirebaseFirestore.instance.collection("users").doc(userId);

    try {
      final userData = await userDocumentRef.get();
      final List<dynamic> items = userData['inventory.not_used'];
      return items.map((task) => items.toString()).toList();
    } catch (error) {
      print("Error loading items: $error");
      throw error;
    }
  }

  Future<List<String>> loadUsedItems() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return [];
    }

    final userId = user.uid;
    final userDocumentRef =
        FirebaseFirestore.instance.collection("users").doc(userId);

    try {
      final userData = await userDocumentRef.get();
      final List<dynamic> items = userData['inventory.in_use'];
      return items.map((task) => task.toString()).toList();
    } catch (error) {
      print("Error loading used items: $error");
      throw error;
    }
  }

  Future<void> updateItems(String fieldName, List<String> updatedItems) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return;
    }

    final userId = user.uid;
    final userDocumentRef =
        FirebaseFirestore.instance.collection("users").doc(userId);

    try {
      await userDocumentRef.update({
        fieldName: updatedItems.map((item) => FieldValue.arrayUnion([item])),
      });
    } catch (error) {
      print("Error updating item: $error");
      throw error;
    }
  }

  Future<void> saveGlobal(Map<String, dynamic> globalData) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return;
    }
    final userId = user.uid;
    final userDocumentRef = database.collection("users").doc(userId);
    final globalId = globalData['global_id'];
    try {
      await userDocumentRef.update({
        "global_object.$globalId": globalData,
      });
    } catch (error) {
      print("Error saving this global information: $error");
      throw error;
    }
  }
}
