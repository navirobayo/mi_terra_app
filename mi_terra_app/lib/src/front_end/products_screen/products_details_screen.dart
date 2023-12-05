import 'package:flutter/material.dart';
import 'package:mi_terra_app/src/back_end/components/global_strings.dart';

double defaultTextSpacer = 60;
double defaultCardSpacer = 20;

class ProductsDetailsScreen extends StatelessWidget {
  const ProductsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(testHarvestTitle1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
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
                          "https://as1.ftcdn.net/v2/jpg/06/28/98/30/1000_F_628983007_ot4QbSRTc1RrJMdjSHHyf0VeBMbV5PiC.jpg"),
                    ),
                  ),
                ),
                const Column(
                  children: [
                    Text("En cosecha: $testHarvestTime1"),
                    Text("Se riega cada: $testWaterTime1"),
                    Text("Semillas/plantas: $testNumberOfSeeds"),
                  ],
                ),
              ],
            ),
            Container(
              height: 150,
              child: ListView(
                children: const [
                  ListTile(
                    leading: Text(testHarvest1Date),
                    title: Text(testHarvestNote1),
                  ),
                  ListTile(
                    leading: Text(testHarvest1Date),
                    title: Text(testHarvestNote1),
                  ),
                  ListTile(
                    leading: Text(testHarvest1Date),
                    title: Text(testHarvestNote1),
                  ),
                  ListTile(
                    leading: Text(testHarvest1Date),
                    title: Text(testHarvestNote1),
                  ),
                  ListTile(
                    leading: Text(testHarvest1Date),
                    title: Text(testHarvestNote1),
                  ),
                  ListTile(
                    leading: Text(testHarvest1Date),
                    title: Text(testHarvestNote1),
                  ),
                  ListTile(
                    leading: Text(testHarvest1Date),
                    title: Text(testHarvestNote1),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                child: Row(
                  children: [
                    // Left Column: Text Widgets
                    Expanded(
                      flex: 1, // Takes half of the available space
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 40),
                          Text("Notificaciones: Activadas."),
                          SizedBox(height: defaultTextSpacer),
                          Text("Notificaciones: Activadas."),
                          SizedBox(height: defaultTextSpacer),
                          Text("Notificaciones: Activadas."),
                          SizedBox(height: defaultTextSpacer),
                        ],
                      ),
                    ),
                    // Right Column: Card Buttons
                    Expanded(
                      flex: 1, // Takes half of the available space
                      child: Column(
                        children: [
                          IconButton.outlined(
                              onPressed: () {
                                print("test");
                              },
                              icon: Icon(Icons.notification_add)),
                          SizedBox(height: defaultCardSpacer),
                          IconButton.outlined(
                              onPressed: () {
                                print("test");
                              },
                              icon: Icon(Icons.notification_add)),
                          SizedBox(height: defaultCardSpacer),
                          IconButton.outlined(
                              onPressed: () {
                                print("test");
                              },
                              icon: Icon(Icons.notification_add)),
                          SizedBox(height: defaultCardSpacer),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
