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
}

//* Note: The controller of data needs to have a beggining date, based on that the app should calculate the production time. In this way even if the user changes the beggining date, the same function will calculate how much time is in production (taking into account the actual date)
