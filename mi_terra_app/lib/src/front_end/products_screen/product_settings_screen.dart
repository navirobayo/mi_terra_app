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
          title: Text("Actualizar número de plantas / animales"),
        ),
        ListTile(
          title: Text("Actualizar frecuencia de producción"),
        ),
        ListTile(
          title: Text("Ver histórico de gastos"),
        ),
        ListTile(
          title: Text("Ver histórico de ventas"),
        ),
        ListTile(
          title: Text("Modificar ganancias"),
        ),
        ListTile(
          title: Text("Modificar gastos"),
        ),
        ListTile(
          title: Text("Modificar ventas totales"),
        ),
        ListTile(
          title: Text("Publicar en catálogo virtual"),
        ),
        ListTile(
          title: Text(
              "Generar reporte"), //* Esta pantalla puede mostrar también el tiempo que lleva en producción.
        ),
      ],
    ));
  }
}
