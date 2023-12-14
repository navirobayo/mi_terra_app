import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/user_repository.dart';

class ProductsController extends GetxController {
  final UserRepository userRepository = UserRepository.instance;
  final products = <Map<String, dynamic>>[].obs;

  Future<void> getUserProducts() async {
    try {
      products.assignAll(await userRepository.getUserProducts());
    } catch (error) {
      print('Error fetching user products: $error');
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await userRepository.deleteProduct(productId);
      products.removeWhere((product) => product['product_id'] == productId);
      Get.snackbar('Perfecto', 'Tu producto ha sido eliminado');
    } catch (error) {
      Get.snackbar('Error', 'No se ha podido eliminar el producto: $error');
      print("Error deleting product: $error");
    }
  }

  Future<void> fetchUserProductsIfNeeded() async {
    if (products.isEmpty) {
      await getUserProducts();
    }
  }
}
