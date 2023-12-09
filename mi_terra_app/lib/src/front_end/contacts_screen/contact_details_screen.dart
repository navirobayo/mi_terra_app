import 'package:flutter/material.dart';
import 'package:mi_terra_app/src/front_end/products_screen/product_settings_screen.dart';

class ContactDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> contactData;

  const ContactDetailsScreen({Key? key, required this.contactData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(title: const Text("Contacto"), actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProductSettingsScreen(),
              ));
            },
            icon: const Icon(Icons.edit))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nombre: ${contactData['contact_name']}"),
            Text("Nota: ${contactData['contact_note']}"),
            Text("Ubicación: ${contactData['contact_location']}"),
            SelectableText("Celular: ${contactData['contact_phone']}"),
            SelectableText(
                "Redes sociales: ${contactData['contact_social_media']}"),
          ],
        ),
      ),
    );
  }
}
