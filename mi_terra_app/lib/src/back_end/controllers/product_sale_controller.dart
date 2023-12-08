/* import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/user_repository.dart';

class ProductSaleController extends GetxController {
  static ProductSaleController get instance => Get.find();

  //! To do: Add snackbar confirming the update in the product.

  Future<void> saleProduct(String productId) async {
    try {
      // Assuming you have the productData available in the controller or passed to the method
      final Map<String, dynamic> productData = /* get your product data here */;

      // Update the values for the sale
      final int newProfits = productData['product_profits'] + 1;
      final int newProductsReady = productData['products_ready'] - 1;
      final int newProductSales = productData['product_sales'] + 1;

      // Prepare the data for updating the product
      final Map<String, dynamic> newSaleData = {
        'product_profits': newProfits,
        'products_ready': newProductsReady,
        'product_sales': newProductSales,
      };

      await UserRepository.instance.saveSale(newSaleData);
    } catch (error) {
      print("error: $error");
    }
  }
}

*/