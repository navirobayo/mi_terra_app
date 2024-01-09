import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/controllers/registration_controller.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegistrationController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text("Crea tu cuenta"),
                Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controller.terraEmail,
                          decoration: const InputDecoration(
                              labelText: "Tu correo electrónico"),
                        ),
                        TextFormField(
                          controller: controller.terraPassword,
                          decoration: const InputDecoration(
                              labelText: "Crea una contraseña"),
                        ),
                        TextFormField(
                          controller: controller.terraUsername,
                          decoration: const InputDecoration(
                              labelText: "Tu nombre o el de tu negocio"),
                        ),
                        TextButton(
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                RegistrationController.instance.registerUser(
                                    controller.terraEmail.text.trim(),
                                    controller.terraPassword.text.trim());
                              }
                            },
                            child: const Text("Registrarme")),
                        const Text("O"),
                        const TextButton(
                            onPressed: null,
                            child: Text("Registrarme con Google"))
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
