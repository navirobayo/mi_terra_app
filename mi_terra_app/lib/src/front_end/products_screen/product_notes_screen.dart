import 'package:flutter/material.dart';
import 'package:mi_terra_app/src/back_end/components/global_strings.dart';

class ProductNotesScreen extends StatelessWidget {
  const ProductNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          ListTile(
            leading: Text(testHarvest1Date),
            title: Text(
                "aslkdjklasjdñaskldfjasñdflkjasdñfklasdjfñaklsdfjñaskldfjañslkdfj"),
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
    );
  }
}
