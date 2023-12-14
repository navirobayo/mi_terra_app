import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/controllers/expense_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/product_units_controller.dart';
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
                        return 'Entra una cantidad mínima';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Comentario",
                    ),
                    controller: saleController.productCommentary,
                  ),
                  TextButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        saleController.createSale(productData);
                        //Then calculate the profits.
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

  Future<void> createNewExpense(BuildContext context, String productId) async {
    final ExpenseController expenseController = Get.find<ExpenseController>();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Añadir gasto"),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Precio unidad",
                    ),
                    keyboardType: TextInputType.number,
                    controller: expenseController.expensePricePerUnit,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Unidades compradas",
                    ),
                    controller: expenseController.expenseQuantity,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingresa una cantidad mínima';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "¿Qué compraste?",
                    ),
                    controller: expenseController.expenseItemName,
                  ),
                  TextButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        expenseController.createExpense(productData);
                        // Then. Execute the calculation of profits here.
                        Get.offAll(const HomeScreen());
                      }
                    },
                    child: const Text("Añadir nuevo gasto"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> addNewAvailableProduct(
      BuildContext context, String productId) async {
    final ProductUnitsController productUnitsController =
        Get.find<ProductUnitsController>();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Productos listos para venta"),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Cantidad de productos",
                    ),
                    controller: productUnitsController.productQuantity,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingresa una cantidad mínima';
                      }
                      return null;
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        productUnitsController.addUnit(productData);
                        Get.offAll(const HomeScreen());
                      }
                    },
                    child: const Text("Añadir producto(s)"),
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
            SizedBox(
              height: 4,
            ),
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
                    Text(
                      '\$ ${(productData['product_price'] as double)}',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text("Plantas / animales: ${productData['product_units']}"),
                    Text(
                        "Producto listo cada: ${productData['product_frequency']} días"),
                    Text(
                        "Ventas totales: ${productData['product_sales_counter']}"),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 6,
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
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Ventas: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Text("\$ ${productData['product_sales_net_value']}",
                          style: Theme.of(context).textTheme.headlineMedium)
                    ],
                  ),
                  Row(
                    children: [
                      Text("Ganancias: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Text("\$ ${productData['product_profits']}",
                          style: Theme.of(context).textTheme.headlineMedium)
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Gastos: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text("\$ ${productData['product_spent_net_value']}",
                          style: Theme.of(context).textTheme.headlineMedium)
                    ],
                  ),
                  Row(
                    children: [
                      Text("Disponibles: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Text(productData['products_ready'].toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium) //* Tiene que ser negativo si ya hay prevendidos
                    ],
                  ),
                ],
              ),
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
                  createNewExpense(
                    context,
                    productData['product_id'],
                  );
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
                  addNewAvailableProduct(
                    context,
                    productData['product_id'],
                  );
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
