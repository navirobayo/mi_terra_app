import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/controllers/user_catalog_controller.dart';
import 'package:mi_terra_app/src/front_end/store_screen/public_product_view_screen.dart';

class UserCatalogScreen extends StatelessWidget {
  const UserCatalogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserCatalogController userCatalogController =
        Get.find<UserCatalogController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Catálogo en línea"),
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.picture_as_pdf_sharp)),
          IconButton(onPressed: null, icon: Icon(Icons.share)),
        ],
      ),
      body: FutureBuilder(
        future: userCatalogController.getAvailableUserProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Obx(
              () => userCatalogController.publicProducts.isEmpty
                  ? const Center(child: Text('Tu catálogo está vacio'))
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: userCatalogController.publicProducts.length,
                      itemBuilder: (context, index) {
                        final product =
                            userCatalogController.publicProducts[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PublicProductViewScreen(product: product),
                              ),
                            );
                          },
                          child: Card(
                            color: Theme.of(context).colorScheme.onBackground,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 100,
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
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return const Center(
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
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(product['product_name']),
                                          Text(
                                            "\$${product['product_price'] ?? 0}",
                                          ),
                                          Text(
                                            "${product['products_ready'] ?? 0} Disponibles",
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      const IconButton(
                                          onPressed: null,
                                          icon: Icon(Icons.logout))
                                    ],
                                  )
                                ],
                              ),
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
