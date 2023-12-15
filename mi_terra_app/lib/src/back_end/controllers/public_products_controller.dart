import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/user_repository.dart';

class PublicProductsController extends GetxController {
  final UserRepository userRepository = UserRepository.instance;
  final publicProducts = <Map<String, dynamic>>[].obs;

  Future<void> getAvailablePublicProducts() async {
    try {
      final products = await userRepository.getAvailablePublicProducts();
      publicProducts.assignAll(products);
    } catch (error) {
      print('Error fetching available public products: $error');
    }
  }
}
