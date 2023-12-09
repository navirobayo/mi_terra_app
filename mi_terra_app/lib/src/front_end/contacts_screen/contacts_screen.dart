import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/controllers/contact_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/contacts_controller.dart';
import 'package:mi_terra_app/src/front_end/contacts_screen/contact_details_screen.dart';
import 'package:mi_terra_app/src/front_end/home_screen/home_screen.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  Future<void> createNewContact(BuildContext context) async {
    final controller = Get.put(ContactController());
    final formKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Nuevo contacto"),
            content: SingleChildScrollView(
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Nombre de contacto",
                        ),
                        controller: controller.contactName,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Número de contacto",
                        ),
                        controller: controller.contactPhone,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Nota acerca este contacto",
                        ),
                        controller: controller.contactNote,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Ubicación - Dirección",
                        ),
                        controller: controller.contactLocation,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Redes sociales",
                        ),
                        controller: controller.contactSocialMedia,
                      ),
                      TextButton(
                          onPressed: () {
                            controller.createContact();
                            Get.offAll(const HomeScreen());
                          },
                          child: const Text("Crear contacto")),
                    ],
                  )),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final ContactsController contactsController =
        Get.find<ContactsController>();
    return Scaffold(
      appBar: AppBar(title: const Text("Contactos")),
      body: FutureBuilder(
        future: contactsController.getUserContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Obx(
              () => contactsController.contacts.isEmpty
                  ? const Center(
                      child: Text('No has registrado ningún contacto!'))
                  : ListView.builder(
                      itemCount: contactsController.contacts.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Nombre: ${contactsController.contacts[index]['contact_name']}"),
                                Text(
                                    "Nota: ${contactsController.contacts[index]['contact_note']}"),
                                Text(
                                    "Ubicación: ${contactsController.contacts[index]['contact_location']}"),
                                SelectableText(
                                    "Celular: ${contactsController.contacts[index]['contact_phone']}"),
                                SelectableText(
                                    "Redes sociales: ${contactsController.contacts[index]['contact_social_media']}"),
                              ],
                            ),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    actions: [
                                      Row(
                                        children: [
                                          Text("Llamar"),
                                          IconButton(
                                              onPressed: null,
                                              icon: Icon(Icons.call)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Editar"),
                                          IconButton(
                                              onPressed: null,
                                              icon: Icon(Icons.edit)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Eliminar"),
                                          IconButton(
                                              onPressed: null,
                                              icon: Icon(Icons.delete)),
                                        ],
                                      ),
                                    ],
                                  );
                                });
                          },
                        );
                      },
                    ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewContact(context);
        },
        child: Icon(Icons.add_call),
      ),
    );
  }
}
