import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/components/global_strings.dart';
import 'package:mi_terra_app/src/back_end/controllers/button_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/products_controller.dart';
import 'package:mi_terra_app/src/front_end/contacts_screen/contacts_screen.dart';
import 'package:mi_terra_app/src/front_end/home_screen/order_type_button.dart';
import 'package:mi_terra_app/src/front_end/products_screen/products_screen.dart';
import 'package:mi_terra_app/src/front_end/settings_screen/settings_screen.dart';
import 'package:mi_terra_app/src/front_end/store_screen/store_screen.dart';
import 'package:mi_terra_app/src/front_end/tasks_screen/tasks_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void addNewExpense(BuildContext context) {
    final ButtonController buttonController = Get.find<ButtonController>();
    final ProductsController productsController =
        Get.find<ProductsController>();
    final List<String> productNames = productsController.products
        .map<String>((product) => product['product_name'] as String)
        .toList();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Nuevo gasto"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                // Dynamically build radio buttons for user products
                for (var productName in productNames)
                  RadioButtonWidget(
                    value: productName,
                    title: productName,
                  ),
                // Add "Gasto general" option
                RadioButtonWidget(
                  value: 'Gasto general',
                  title: 'Gasto general',
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: const Text("Añadir"),
                  onTap: () {
                    // Handle the logic when "Añadir" is tapped
                    print("Selected order type: ${buttonController.orderType}");
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: const Text("Cancelar"),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Hola, $testUserName"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ));
                },
                icon: const Icon(Icons.settings))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: ListView(
            children: [
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(12),
                      child: IconButton.outlined(
                        icon: Icon(Icons.storefront_sharp),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const StoreScreen(),
                          ));
                        },
                      )),
                  const Text(
                    "Mi tienda",
                    // style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 3,
                    child: InkWell(
                      splashColor: Theme.of(context).colorScheme.primary,
                      onTap: () {},
                      child: const SizedBox(
                        width: 150,
                        height: 150,
                        child: Center(child: Text('Inventario')),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 3,
                    child: InkWell(
                      splashColor: Theme.of(context).colorScheme.primary,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TasksScreen(),
                        ));
                      },
                      child: const SizedBox(
                        width: 150,
                        height: 150,
                        child: Center(child: Text('Pendientes')),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 3,
                    child: InkWell(
                      splashColor: Theme.of(context).colorScheme.primary,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProductsScreen(),
                        ));
                      },
                      child: const SizedBox(
                        width: 150,
                        height: 150,
                        child: Center(child: Text('Mis productos')),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Column(
                    children: [
                      Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        clipBehavior: Clip.hardEdge,
                        elevation: 3,
                        child: InkWell(
                          splashColor:
                              Theme.of(context).colorScheme.onSurfaceVariant,
                          onTap: () {
                            addNewExpense(context);
                          },
                          child: const SizedBox(
                            width: 150,
                            height: 60,
                            child: Center(child: Text('Añadir gasto')),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        clipBehavior: Clip.hardEdge,
                        elevation: 3,
                        child: InkWell(
                          splashColor:
                              Theme.of(context).colorScheme.onSurfaceVariant,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const StoreScreen(),
                            ));
                          },
                          child: const SizedBox(
                            width: 150,
                            height: 60,
                            child: Center(child: Text('Añadir venta')),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 3,
                    child: InkWell(
                      splashColor: Theme.of(context).colorScheme.primary,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ContactsScreen(),
                        ));
                      },
                      child: const SizedBox(
                        width: 150,
                        height: 150,
                        child: Center(child: Text('Contactos')),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 3,
                    child: InkWell(
                      splashColor: Theme.of(context).colorScheme.primary,
                      onTap: () {},
                      child: const SizedBox(
                        width: 150,
                        height: 150,
                        child: Center(child: Text('Mis finanzas')),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
