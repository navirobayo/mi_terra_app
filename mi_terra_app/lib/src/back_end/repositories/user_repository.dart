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

    try {
      // Access the product_id field and then the product_sales map to update the specific product with sale information.
      await userDocumentRef.update({
        "products.$productId.product_sales": FieldValue.arrayUnion([saleData]),
      });
    } catch (error) {
      print("Error guardando esta venta: $error");
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
