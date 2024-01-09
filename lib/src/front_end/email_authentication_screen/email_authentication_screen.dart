import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/controllers/login_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/registration_controller.dart';

class EmailAuthenticationScreen extends StatelessWidget {
  const EmailAuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final _formKey = GlobalKey<FormState>();
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
                const Text("Ingresa tu correo y contraseña"),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controller.terraEmail,
                          decoration:
                              const InputDecoration(labelText: "Correo"),
                        ),
                        TextFormField(
                          controller: controller.terraPassword,
                          decoration:
                              const InputDecoration(labelText: "Contraseña"),
                        ),
                        TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                LoginController.instance.loginUser(
                                    controller.terraEmail.text.trim(),
                                    controller.terraPassword.text.trim());
                              }
                            },
                            child: const Text("Ingresar")),
                        const Text("O"),
                        const TextButton(
                            onPressed: null,
                            child: Text("Ingresar con Google")),
                        const TextButton(
                            onPressed: null,
                            child: Text("Olvidé mi contraseña"))
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
