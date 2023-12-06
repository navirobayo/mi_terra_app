import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/controllers/product_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/products_controller.dart';
import 'package:mi_terra_app/src/front_end/products_screen/products_details_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  Future<void> createNewProduct(BuildContext context) async {
    final controller = Get.put(ProductController());
    final formKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Nuevo producto"),
            content: SingleChildScrollView(
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.productName,
                      ),
                      TextButton(
                          onPressed: () {
                            controller.createProduct();
                            Navigator.of(context).pop();
                          },
                          child: const Text("Crear producto")),
                    ],
                  )),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final ProductsController productsController =
        Get.find<ProductsController>();
    return Scaffold(
      body: FutureBuilder(
        future: productsController.getUserProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Obx(
              () => productsController.products.isEmpty
                  ? const Center(child: Text('No has creado ningún producto!'))
                  : ListView.builder(
                      itemCount: productsController.products.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(productsController.products[index]
                              ['product_name']),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const ProductsDetailsScreen(),
                            ));
                          },
                        );
                      },
                    ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            createNewProduct(context);
          },
          label: const Text("Crear producto")),
    );
  }
}
