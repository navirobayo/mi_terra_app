import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/controllers/inventory_controller.dart';
import 'package:mi_terra_app/src/front_end/home_screen/home_screen.dart';

enum ItemStatus { pending, used }

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  ItemStatus selectedStatus = ItemStatus.pending;

  Future<void> createNewItem(BuildContext context) async {
    final InventoryController inventoryController =
        Get.find<InventoryController>();
    final formKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Agregar item"),
            content: SingleChildScrollView(
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Elemento sin utilizar",
                        ),
                        controller: inventoryController.itemName,
                      ),
                      TextButton(
                          onPressed: () {
                            inventoryController.createItem();
                            Get.offAll(const HomeScreen());
                          },
                          child: const Text("Crear item")),
                    ],
                  )),
            ),
          );
        });
  }

  void handleElevatedButton(BuildContext context, int index) {
    final InventoryController inventoryController =
        Get.find<InventoryController>();
    final TextEditingController locationController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Agregar a elementos en uso"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "¿Donde se utiliza?",
                  ),
                  controller: locationController,
                ),
                TextButton(
                  onPressed: () {
                    if (locationController.text.isNotEmpty) {
                      inventoryController.moveToUsedItems(
                          index, locationController.text);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Aceptar"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final inventoryController = Get.find<InventoryController>();
      if (selectedStatus == ItemStatus.pending) {
        await inventoryController.loadNotUsedItems();
      } else {
        await inventoryController.loadUsedItems();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SegmentedButton<ItemStatus>(
              segments: const <ButtonSegment<ItemStatus>>[
                ButtonSegment<ItemStatus>(
                  value: ItemStatus.pending,
                  label: Text('Sin usar'),
                ),
                ButtonSegment<ItemStatus>(
                  value: ItemStatus.used,
                  label: Text('En uso'),
                ),
              ],
              selected: <ItemStatus>{selectedStatus},
              onSelectionChanged: (Set<ItemStatus> newSelection) {
                setState(() {
                  selectedStatus = newSelection.first;
                });
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              final inventoryController = Get.find<InventoryController>();
              final List<String> items = selectedStatus == ItemStatus.pending
                  ? inventoryController.pendingItems
                  : inventoryController.usedItems;

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index]),
                    trailing: selectedStatus == ItemStatus.pending
                        ? ElevatedButton(
                            onPressed: () {
                              handleElevatedButton(context, index);
                            },
                            child: const Icon(Icons.done),
                          )
                        : const SizedBox.shrink(),
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
                                      inventoryController.deleteItem(
                                          index, selectedStatus);
                                      Navigator.of(context).pop();
                                    },
                                    child:
                                        const Text("Eliminar permanentemente"))
                              ],
                            );
                          });
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            createNewItem(context);
          },
          child: const Icon(Icons.add)),
    );
  }
}
