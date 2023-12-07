import 'package:flutter/material.dart';

class ProductSettingsScreen extends StatelessWidget {
  const ProductSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        ListTile(
          title: Text("Modificar nombre del producto"),
        ),
        ListTile(
          title: Text("Modificar fecha de inicio de producción"),
        ),
      ],
    ));
  }
}
