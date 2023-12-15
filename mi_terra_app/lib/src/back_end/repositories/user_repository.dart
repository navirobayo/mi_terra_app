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

  Future<void> deleteProduct(String productId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return;
    }

    final userId = user.uid;
    final userDocumentRef = database.collection("users").doc(userId);

    try {
      await userDocumentRef.update({
        "products.$productId": FieldValue.delete(),
      });
    } catch (error) {
      print("Error deleting product: $error");
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

  Future<List<Map<String, dynamic>>> getGlobalObject() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return [];
    }

    final userId = user.uid;
    final userDocumentRef = database.collection("users").doc(userId);

    final userData = await userDocumentRef.get();
    final products = userData.data()?['global_data'] ?? {};

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
    final double soldUnits = saleData['product_quantity'] as double;

    try {
      await userDocumentRef.update({
        "products.$productId.product_sales.$saleId": saleData,
        "products.$productId.product_sales_counter": FieldValue.increment(1),
        "products.$productId.product_sales_net_value":
            FieldValue.increment(totalSale),
        "products.$productId.products_ready": FieldValue.increment(-soldUnits),
      });
      await updateProductProfits(productId);
      await updatePublicProductObject(productId, userId);
    } catch (error) {
      print("Error guardando esta venta: $error");
      throw error;
    }
  }

  Future<void> updatePublicProductObject(
      String productId, String userId) async {
    final userDocumentRef = database.collection("users").doc(userId);
    final storeDocumentRef = database.collection("store").doc(productId);

    try {
      // Fetch the most up-to-date available quantity from the user's document
      final userDocumentSnapshot = await userDocumentRef.get();
      final userProductData =
          userDocumentSnapshot.data() as Map<String, dynamic>;
      final double productQuantityValue =
          userProductData['products'][productId]['products_ready'] ?? 0;

      if (productQuantityValue > 0) {
        // Update the products_ready field in the public product object
        await storeDocumentRef.update({
          'user_id': userId,
          'products_ready': productQuantityValue,
        });
      } else {
        // Delete the public product object if available quantity is not greater than 0
        await storeDocumentRef.delete();
      }
    } catch (error) {
      print("Error updating public product object: $error");
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
      await updateProductProfits(productId);
    } catch (error) {
      print("Error guardando esta venta: $error");
      throw error;
    }
  }

  Future<void> saveGeneralExpense(Map<String, dynamic> expenseData) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return;
    }

    final userId = user.uid;
    final userDocumentRef = database.collection("users").doc(userId);
    const globalId = "global_expenses";
    final expenseId = expenseData['general_expense_id'];
    final double totalSpent = expenseData['total_spent'] as double;

    try {
      await userDocumentRef.update({
        "global_data.$globalId.$expenseId": expenseData,
        "global_data.global_spent_net_value": FieldValue.increment(totalSpent),
      });
      await updateGlobalProfits(globalId);
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

  Future<void> movePendingItem(String movedItem, String location) async {
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
        // Modify the "inventory.in_use" map to include the item name and its location
        "inventory.in_use": {
          movedItem: {"location": location}
        },
        "inventory.not_used": FieldValue.arrayRemove([movedItem]),
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
      return items.map((item) => item.toString()).toList();
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
      return items.map((item) => item.toString()).toList();
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

  Future<void> saveUnitsQuantity(Map<String, dynamic> unitData) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return;
    }

    final userId = user.uid;
    final userDocumentRef = database.collection("users").doc(userId);
    final productId = unitData['product_id'];
    final double totalUnits = unitData['unit_quantity'] as double;

    try {
      await userDocumentRef.update({
        "products.$productId.products_ready": FieldValue.increment(totalUnits),
      });
    } catch (error) {
      print("Error añadiendo unidades : $error");
      throw error;
    }
  }

  Future<void> createPublicProductObject(
      Map<String, dynamic> productData) async {
    final productId = productData['product_id'];
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("User is not authenticated.");
      return;
    }

    final userId = user.uid;
    final userDocumentRef = database.collection("users").doc(userId);
    final storeDocumentRef = database.collection("store").doc(productId);

    try {
      // Remove unnecessary fields from the product data
      productData.remove('product_expenses');
      productData.remove('product_notes');
      productData.remove('product_profits');
      productData.remove('product_creation');
      productData.remove('product_sales_counter');
      productData.remove('product_sales_net_value');
      productData.remove('product_spent_net_value');
      productData.remove('product_sales');
      productData.remove('product_units');

      // Include userId field in the public product data
      productData['user_id'] = userId;

      // Fetch the most up-to-date available quantity from the user's document
      final userDocumentSnapshot = await userDocumentRef.get();
      final userProductData =
          userDocumentSnapshot.data() as Map<String, dynamic>;
      final double productQuantityValue =
          userProductData['products'][productId]['products_ready'] ?? 0;

      // Update the products_ready field with the current available quantity
      productData['products_ready'] = productQuantityValue;

      // Create a copy of the product in the "store" collection
      await storeDocumentRef.set(productData);
    } catch (error) {
      print("Error creating public product object: $error");
      throw error;
    }
  }

  Future<void> updateProductProfits(String productId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return;
    }

    final userId = user.uid;
    final userDocumentRef = database.collection("users").doc(userId);

    try {
      final DocumentSnapshot userSnapshot = await userDocumentRef.get();

      final Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;

      final Map<String, dynamic>? productsData =
          userData?["products"] as Map<String, dynamic>?;

      final Map<String, dynamic> productData =
          productsData?[productId] as Map<String, dynamic>? ?? {};

      final double salesNetValue =
          (productData['product_sales_net_value'] ?? 0).toDouble();
      final double spentNetValue =
          (productData['product_spent_net_value'] ?? 0).toDouble();

      final double profits = salesNetValue - spentNetValue;

      print("Calculated Profits for $productId: $profits");

      // Update product_profits
      await userDocumentRef.update({
        "products.$productId.product_profits": profits,
      });

      print("Updated product_profits for $productId");
    } catch (error) {
      print("Error updating product profits: $error");
    }
  }

  Future<void> updateGlobalProfits(String globalId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated.");
      return;
    }

    final userId = user.uid;
    final userDocumentRef = database.collection("users").doc(userId);

    try {
      final userDocumentSnapshot = await userDocumentRef.get();
      final userData = userDocumentSnapshot.data() as Map<String, dynamic>;

      final globalData = userData["global_data"] as Map<String, dynamic>;

      final profits = (globalData["global_profits"] ?? 0) -
          (globalData["global_spent_net_value"] ?? 0);

      await userDocumentRef.update({
        "global_data.global_profits": profits,
      });

      print("Updated global profits");
    } catch (error) {
      print("Error updating global profits: $error");
    }
  }

  Future<List<Map<String, dynamic>>> getAvailablePublicProducts() async {
    final storeCollection = FirebaseFirestore.instance.collection('store');

    try {
      final querySnapshot = await storeCollection.get();
      final publicProducts = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      // Filter out products with available quantity less than or equal to 0
      final filteredPublicProducts = publicProducts
          .where((product) => (product['products_ready'] ?? 0) > 0)
          .toList();

      return filteredPublicProducts;
    } catch (error) {
      print("Error fetching available public products: $error");
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
