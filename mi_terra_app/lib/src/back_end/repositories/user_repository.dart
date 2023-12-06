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
}
