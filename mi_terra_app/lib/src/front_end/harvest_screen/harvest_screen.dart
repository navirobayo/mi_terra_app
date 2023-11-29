import 'package:flutter/material.dart';
import 'package:mi_terra_app/src/front_end/harvest_screen/harvest_details_screen.dart';

class HarvestScreen extends StatelessWidget {
  const HarvestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        ListTile(
          title: Text("Espinaca"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const HarvestDetailsScreen(),
            ));
          },
        )
      ],
    ));
  }
}
