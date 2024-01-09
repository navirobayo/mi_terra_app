import 'package:flutter/material.dart';
import 'package:mi_terra_app/src/back_end/repositories/authentication_repository.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        ListTile(
          title: const Text("Cerrar sesión"),
          subtitle: const Text("Hasta la vista vaquero/a"),
          trailing: const Icon(Icons.logout),
          onTap: () {
            AuthenticationRepository.instance.logout();
          },
        )
      ]),
    );
  }
}
