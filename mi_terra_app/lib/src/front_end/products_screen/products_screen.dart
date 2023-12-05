import 'package:flutter/material.dart';
import 'package:mi_terra_app/src/front_end/products_screen/products_details_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        ListTile(
          title: Text("Espinaca"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ProductsDetailsScreen(),
            ));
          },
        )
      ],
    ));
  }
}
