import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/components/custom_connectivity_widget.dart';
import 'package:mi_terra_app/src/back_end/controllers/expense_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/general_expense_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/get_global_data_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/getx_network_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/radio_button_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/get_products_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/sale_controller.dart';
import 'package:mi_terra_app/src/front_end/contacts_screen/contacts_screen.dart';
import 'package:mi_terra_app/src/front_end/home_screen/order_type_button.dart';
import 'package:mi_terra_app/src/front_end/inventory_screen/inventory_screen.dart';
import 'package:mi_terra_app/src/front_end/products_screen/products_screen.dart';
import 'package:mi_terra_app/src/front_end/profit_screen/profit_screen.dart';
import 'package:mi_terra_app/src/front_end/settings_screen/settings_screen.dart';
import 'package:mi_terra_app/src/front_end/store_screen/store_screen.dart';
import 'package:mi_terra_app/src/front_end/tasks_screen/tasks_screen.dart';
import 'package:mi_terra_app/src/front_end/user_catalog_screen/user_catalog_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void showProfileView(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text("Mi Terra Perfil"),
          content: SingleChildScrollView(
            child: Column(
              children: [],
            ),
          ),
        );
      },
    );
  }

  void showSelectionMenuForExpenses(BuildContext context) async {
    final ButtonController buttonController = Get.find<ButtonController>();
    final ProductsController productsController =
        Get.find<ProductsController>();

    // Fetch user products if not available
    await productsController.fetchUserProductsIfNeeded();

    final List<Map<String, dynamic>> products = productsController.products;

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Nuevo gasto"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                // Dynamically build radio buttons for user products
                for (var product in products)
                  RadioButtonWidget(
                    value: product['product_id'] as String,
                    title: product['product_name'] as String,
                  ),
                // Add "Gasto general" option
                const RadioButtonWidget(
                  value: 'Gasto general',
                  title: 'Gasto general',
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: const Text("Añadir"),
                  onTap: () {
                    if (buttonController.orderType == 'Gasto general') {
                      print("User selected 'Gasto General'");
                      Navigator.of(context).pop();
                      showDetailedGeneralExpenseDialog(context);
                    } else {
                      final selectedProduct = products.firstWhere(
                        (product) =>
                            product['product_id'] == buttonController.orderType,
                      );

                      if (selectedProduct != null) {
                        Navigator.of(context).pop();
                        showDetailedExpenseDialog(context, selectedProduct);
                      } else {
                        print("Error: Selected product not found");
                      }
                    }
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

  void showSelectionMenuForSales(BuildContext context) async {
    final ButtonController buttonController = Get.find<ButtonController>();
    final ProductsController productsController =
        Get.find<ProductsController>();

    // Fetch user products if not available
    await productsController.fetchUserProductsIfNeeded();

    final List<Map<String, dynamic>> products = productsController.products;

    // Check if the list of products is empty
    if (products.isEmpty) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Nueva venta"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Text("¡No hay ningún producto para vender!"),
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
      return;
    }

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Nueva venta"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                // Dynamically build radio buttons for user products
                for (var product in products)
                  RadioButtonWidget(
                    value: product['product_id'] as String,
                    title: product['product_name'] as String,
                  ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: const Text("Añadir"),
                  onTap: () {
                    final selectedProduct = products.firstWhere(
                      (product) =>
                          product['product_id'] == buttonController.orderType,
                    );

                    if (selectedProduct != null) {
                      Navigator.of(context).pop();
                      showDetailedSellDialog(context, selectedProduct);
                    } else {
                      print("Error: Selected product not found");
                    }
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

  void showDetailedExpenseDialog(
      BuildContext context, Map<String, dynamic> productData) {
    final ExpenseController expenseController = Get.find<ExpenseController>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Nuevo gasto para ${productData['product_name']}"),
          content: SingleChildScrollView(
            child: Form(
              key: expenseController.formKey,
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
                    onPressed: () async {
                      if (expenseController.formKey.currentState?.validate() ??
                          false) {
                        await expenseController.createExpense(productData);
                        Navigator.of(context).pop(); // Close the dialog
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

  void showDetailedSellDialog(
      BuildContext context, Map<String, dynamic> productData) {
    final SaleController saleController = Get.find<SaleController>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Nueva venta"),
          content: SingleChildScrollView(
            child: Form(
              key: saleController.formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
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
                      if (saleController.formKey.currentState?.validate() ??
                          false) {
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

  void showDetailedGeneralExpenseDialog(context) {
    final GeneralExpenseController generalExternalExpenseController =
        Get.find<GeneralExpenseController>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Nuevo gasto general"),
          content: SingleChildScrollView(
            child: Form(
              key: generalExternalExpenseController.formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Precio unidad",
                    ),
                    keyboardType: TextInputType.number,
                    controller:
                        generalExternalExpenseController.expensePricePerUnit,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Unidades compradas",
                    ),
                    controller:
                        generalExternalExpenseController.expenseQuantity,
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
                    controller:
                        generalExternalExpenseController.expenseItemName,
                  ),
                  TextButton(
                    onPressed: () async {
                      if (generalExternalExpenseController.formKey.currentState
                              ?.validate() ??
                          false) {
                        await generalExternalExpenseController
                            .createGeneralExpense();
                        Navigator.of(context).pop(); // Close the dialog
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

  @override
  Widget build(BuildContext context) {
    final ConnectionManagerController connectionManagerController = Get.find<
        ConnectionManagerController>(); //! Check what exactly does this.
    final GetGlobalDataController getGlobalDataController =
        Get.find<GetGlobalDataController>();
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Obx(
            () {
              return Text(
                getGlobalDataController.loading.value
                    ? "Hola, cargando..."
                    : "Hola, ${getGlobalDataController.userName.value}",
              );
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ));
                },
                icon: const Icon(Icons.settings)),
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
                        icon: const Icon(Icons.storefront_sharp),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const UserCatalogScreen(),
                          ));
                        },
                      )),
                  const Text(
                    "Mi Tienda",
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  ConnectivityWidget()
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
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TasksScreen(),
                        ));
                      },
                      child: const SizedBox(
                        width: 150,
                        height: 150,
                        child: Center(child: Text('Pendientes')),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 3,
                    child: InkWell(
                      splashColor: Theme.of(context).colorScheme.primary,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => InventoryScreen(),
                        ));
                      },
                      child: const SizedBox(
                        width: 150,
                        height: 150,
                        child: Center(child: Text('Inventario')),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
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
                    width: 25,
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
                            showSelectionMenuForExpenses(context);
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
                            showSelectionMenuForSales(context);
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
                height: 25,
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
                    width: 25,
                  ),
                  Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 3,
                    child: InkWell(
                      splashColor: Theme.of(context).colorScheme.primary,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const StoreScreen(),
                        ));
                      },
                      child: const SizedBox(
                        width: 150,
                        height: 150,
                        child: Center(child: Text('Vitrina virtual')),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
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
                          builder: (context) => const ProfitScreen(),
                        ));
                      },
                      child: const SizedBox(
                        width: 150,
                        height: 150,
                        child: Center(child: Text('Estadísticas')),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 3,
                    child: InkWell(
                      splashColor: Theme.of(context).colorScheme.primary,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TasksScreen(),
                        ));
                      },
                      child: const SizedBox(
                        width: 150,
                        height: 150,
                        child: Center(child: Text('Cool logo here.')),
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
