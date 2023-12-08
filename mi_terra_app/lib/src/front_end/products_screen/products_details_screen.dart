import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/controllers/product_sale_controller.dart';
import 'package:mi_terra_app/src/front_end/home_screen/home_screen.dart';
import 'package:mi_terra_app/src/front_end/products_screen/product_settings_screen.dart';

class ProductsDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> productData;

  const ProductsDetailsScreen({Key? key, required this.productData})
      : super(key: key);

  /* Future<void> TextEditingDeltaNonTextUpdate(BuildContext context) async {
    final controller = Get.put(ProductSaleController());
    final formKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("¿Que información quieres cambiar?"),
            content: SingleChildScrollView(
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: () {
                            final String productId = productData['product_id'];
                            controller.saleProduct(productId);
                            Get.offAll(const HomeScreen());
                          },
                          child: const Text("Añadir venta")),
                      TextButton(
                          onPressed: () {
                            null;
                          },
                          child: const Text("Otra opción")),
                    ],
                  )),
            ),
          );
        });
  }
*/
  @override
  Widget build(BuildContext context) {
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
                    Text(
                        "Ventas este mes: ${productData['product_monthly_sales']}")
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
                    icon: Icon(Icons.notification_add)),
                SizedBox(
                  width: 30,
                ),
                Text(
                    "Recordatorios: cada ${productData['reminder_frequency']} días"),
              ],
            ),
            Row(
              children: [
                Text("Ganancias: ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text("\$ ${productData['product_profits']}")
              ],
            ),
            Row(
              children: [
                Text(
                  "Gastos: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text("\$ ${productData['product_expenses']}")
              ],
            ),
            Row(
              children: [
                Text("Pre-vendidos: ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text(productData['product_pre_sales'].toString())
              ],
            ),
            Row(
              children: [
                Text("Entregados: ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text(productData['products_ready'].toString())
              ],
            ),
            Row(
              children: [
                Text("Disponibles: ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text(productData['products_ready']
                    .toString()) //* Tiene que ser negativo si ya hay prevendidos
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add_box_outlined),
      ),
    );
  }
}
