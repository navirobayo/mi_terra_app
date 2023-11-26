import 'package:flutter/material.dart';
import 'package:mi_terra_app/src/back_end/components/global_strings.dart';
import 'package:mi_terra_app/src/front_end/email_authentication_screen/email_authentication_screen.dart';
import 'package:mi_terra_app/src/front_end/google_authentication_screen/google_authentication_screen.dart';
import 'package:mi_terra_app/src/front_end/home_screen/home_screen.dart';
import 'package:mi_terra_app/src/front_end/registration_screen/registration_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text("$appName - ¿Qué vas a cultivar hoy?"),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const GoogleAuthenticationScreen(),
                  ));
                },
                child: const Text("Entrar con Google")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EmailAuthenticationScreen(),
                  ));
                },
                child: const Text("Entrar con correo")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RegistrationScreen(),
                  ));
                },
                child: const Text("Crear cuenta")),
            const Spacer(),
            const Text("Ver. $appVersion"),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
