import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/controllers/public_products_controller.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PublicProductsController publicProductsController =
        Get.find<PublicProductsController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Catálogo en línea")),
      body: FutureBuilder(
        future: publicProductsController.getAvailablePublicProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Obx(
              () => publicProductsController.publicProducts.isEmpty
                  ? const Center(child: Text('La tienda está vacia.'))
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: publicProductsController.publicProducts.length,
                      itemBuilder: (context, index) {
                        final product =
                            publicProductsController.publicProducts[index];

                        return Card(
                          color: Theme.of(context).colorScheme.onBackground,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height:
                                      100, // Set a fixed height for the image container
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.network(
                                          product['product_cover'],
                                          fit: BoxFit.cover,
                                          height: double.infinity,
                                          width: double.infinity,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Text(product['product_name'] ?? ''),
                                Text(
                                  "\$${product['product_price'] ?? 0} libra. ${product['products_ready'] ?? 0} Disponibles",
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            );
          }
        },
      ),
    );
  }
}
