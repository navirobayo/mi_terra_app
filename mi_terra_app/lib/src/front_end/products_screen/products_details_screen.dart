import 'package:flutter/material.dart';
import 'package:mi_terra_app/src/back_end/components/global_strings.dart';
import 'package:mi_terra_app/src/front_end/products_screen/product_settings_screen.dart';

double defaultTextSpacer = 60;
double defaultCardSpacer = 20;

class ProductsDetailsScreen extends StatelessWidget {
  const ProductsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(testHarvestTitle1), actions: [
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
                    image: const DecorationImage(
                      image: NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/mi-terra-app.appspot.com/o/terra_database%2FCaptura%20de%20pantalla%202023-12-06%20212051.png?alt=media&token=5c031e59-c48e-4b5c-9aeb-6e0b84c3ca08"),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                const Column(
                  children: [
                    Text("En producción: $testHarvestTime1 días"),
                    Text("Frecuencia de venta: $testProductSaleFrequency días"),
                    Text("Plantas/animales: $testNumberOfSeeds"),
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
                    icon: Icon(Icons.notification_add)),
                IconButton.outlined(
                    onPressed: () {
                      print("test");
                    },
                    icon: Icon(Icons.notification_add)),
                IconButton.outlined(
                    onPressed: () {
                      print("test");
                    },
                    icon: Icon(Icons.notification_add)),
                SizedBox(
                  width: 30,
                ),
                const Text("Recordatorios: cada $testWaterTime1 días"),
              ],
            ),
            Row(
              children: [
                Text("Rendimientos: ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text("\$ $testProductProfit1")
              ],
            ),
            Row(
              children: [
                Text(
                  "Gastos: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text("\$ $testProductExpense1")
              ],
            ),
            Row(
              children: [
                Text("Pre-vendidos: ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text(testProductPreSale1)
              ],
            ),
            Row(
              children: [
                Text("Productos listos: ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text(testProductReady1)
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
