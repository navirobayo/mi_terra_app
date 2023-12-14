import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/controllers/product_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/get_products_controller.dart';
import 'package:mi_terra_app/src/front_end/home_screen/home_screen.dart';
import 'package:mi_terra_app/src/front_end/products_screen/product_details_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  Future<void> createNewProduct(BuildContext context) async {
    final ProductController productController = Get.find<ProductController>();
    final formKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("¿Qué vas a producir?"),
            content: SingleChildScrollView(
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Nombre de tu producto",
                        ),
                        controller: productController.productName,
                      ),
                      TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Precio",
                          ),
                          controller: productController.productPrice,
                          keyboardType: TextInputType.number),
                      TextButton(
                          onPressed: () {
                            productController.createProduct();
                            Get.offAll(const HomeScreen());
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
                          leading: const Icon(Icons.nature),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                  productData:
                                      productsController.products[index]),
                            ));
                          },
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("¿Eliminar?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Cancelar"),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            final productId = productsController
                                                .products[index]['product_id'];
                                            productsController
                                                .deleteProduct(productId);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                              "Eliminar permanentemente"))
                                    ],
                                  );
                                });
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
