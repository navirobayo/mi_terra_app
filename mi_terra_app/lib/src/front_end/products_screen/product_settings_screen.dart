import 'package:flutter/material.dart';

class ProductSettingsScreen extends StatelessWidget {
  const ProductSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        ListTile(
          title: Text("Cambiar nombre"),
        ),
        ListTile(
          title: Text("Cambiar precio"),
        ),
        ListTile(
          title: Text(
              "Ver fecha de inicio de este producto"), //* Esta pantalla puede mostrar también el tiempo que lleva en producción.
        ),
        ListTile(
          title: Text("Cambiar precio"),
        ),
      ],
    ));
  }
}
