import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/user_repository.dart';

class UserCatalogController extends GetxController {
  final UserRepository userRepository = UserRepository.instance;
  final publicProducts = <Map<String, dynamic>>[].obs;

  Future<void> getAvailableUserProducts() async {
    try {
      final products = await userRepository.getAvailableUserProducts();
      publicProducts.assignAll(products);
    } catch (error) {
      print('Error fetching available public products: $error');
    }
  }
}
