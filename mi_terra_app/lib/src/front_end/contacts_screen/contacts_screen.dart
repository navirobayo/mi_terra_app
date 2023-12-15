import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/controllers/contact_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/get_contacts_controller.dart';
import 'package:mi_terra_app/src/front_end/home_screen/home_screen.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  Future<void> createNewContact(BuildContext context) async {
    final contactController = Get.find<ContactController>();
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
                        decoration: const InputDecoration(
                          hintText: "Nombre de contacto",
                        ),
                        controller: contactController.contactName,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Número de contacto",
                        ),
                        controller: contactController.contactPhone,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Nota acerca este contacto",
                        ),
                        controller: contactController.contactNote,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Ubicación - Dirección",
                        ),
                        controller: contactController.contactLocation,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Redes sociales",
                        ),
                        controller: contactController.contactSocialMedia,
                      ),
                      TextButton(
                          onPressed: () {
                            contactController.createContact();
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
                                  content: Text(
                                      "${contactsController.contacts[index]['contact_name']}"),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.call),
                                          onPressed: () {
                                            // Add your call functionality here
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            // Add your edit functionality here
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            // Add your delete functionality here
                                          },
                                        ),
                                      ],
                                    ),
                                    ButtonBar(
                                      alignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            // Add your call functionality here
                                          },
                                          child: Text("Llamar"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Add your edit functionality here
                                          },
                                          child: Text("Editar"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Add your delete functionality here
                                          },
                                          child: Text("Eliminar"),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );
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
