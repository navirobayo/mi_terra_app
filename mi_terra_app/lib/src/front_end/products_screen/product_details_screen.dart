import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/controllers/sale_controller.dart';
import 'package:mi_terra_app/src/front_end/home_screen/home_screen.dart';
import 'package:mi_terra_app/src/front_end/products_screen/product_settings_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> productData;

  const ProductDetailsScreen({Key? key, required this.productData})
      : super(key: key);

  Future<void> createNewSale(BuildContext context, String productId,
      double productPricePerUnit) async {
    final SaleController saleController = Get.find<SaleController>();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Nueva venta"),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Cantidad de unidades",
                    ),
                    controller: saleController.productQuantity,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid quantity';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Comentario",
                    ),
                    controller: saleController.productCommentary,
                  ),
                  TextButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        saleController.createSale(productData);
                        Get.offAll(const HomeScreen());
                      }
                    },
                    child: const Text("Crear venta"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final SaleController saleController = Get.find<SaleController>();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(title: Text(productData['product_name']), actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProductSettingsScreen(),
              ));
            },
            icon: const Icon(Icons.settings))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Row(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(productData['product_cover']),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Text("\$ ${productData['product_price']}",
                        style: Theme.of(context).textTheme.headlineLarge),
                    Text(
                        "Producto listo cada: ${productData['product_frequency']} días"),
                    Text("Plantas / animales: ${productData['product_units']}")
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton.outlined(
                    onPressed: () {
                      print("test");
                    },
                    icon: Icon(Icons.app_registration_outlined)),
                IconButton.outlined(
                    onPressed: () {
                      print("test");
                    },
                    icon: Icon(Icons.camera_alt_outlined)),
                IconButton.outlined(
                    onPressed: () {
                      print("test");
                    },
                    icon: Icon(Icons.qr_code_2_outlined)),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text("Ganancias: ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text("\$ ${productData['product_profits']}",
                    style: Theme.of(context).textTheme.headlineMedium)
              ],
            ),
            Row(
              children: [
                Text(
                  "Gastos: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text("\$ ${productData['product_expenses']}",
                    style: Theme.of(context).textTheme.headlineMedium)
              ],
            ),
            Row(
              children: [
                Text("Disponibles: ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text(productData['products_ready'].toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium) //* Tiene que ser negativo si ya hay prevendidos
              ],
            ),
            Row(
              children: [
                Text("Ventas totales: ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text("Number of sales",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium) //* Tiene que ser negativo si ya hay prevendidos
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              clipBehavior: Clip.hardEdge,
              elevation: 3,
              child: InkWell(
                splashColor: Theme.of(context).colorScheme.onSurfaceVariant,
                onTap: () {
                  createNewSale(context, productData['product_id'],
                      productData['product_price']);
                  Get.offAll(const HomeScreen());
                },
                child: const SizedBox(
                  height: 60,
                  child: Center(child: Text('Nueva venta')),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              clipBehavior: Clip.hardEdge,
              elevation: 3,
              child: InkWell(
                splashColor: Theme.of(context).colorScheme.onSurfaceVariant,
                onTap: () {
                  null;
                },
                child: const SizedBox(
                  height: 60,
                  child: Center(child: Text('Añadir gasto')),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              clipBehavior: Clip.hardEdge,
              elevation: 3,
              child: InkWell(
                splashColor: Theme.of(context).colorScheme.onSurfaceVariant,
                onTap: () {
                  null;
                },
                child: const SizedBox(
                  height: 60,
                  child: Center(child: Text('Añadir disponibles')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
