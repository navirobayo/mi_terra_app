import 'package:flutter/material.dart';
import 'package:mi_terra_app/src/components/global_strings.dart';
import 'package:mi_terra_app/src/front_end/home_screen/home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
            const ElevatedButton(
                onPressed: null, child: Text("Entrar con Google")),
            const ElevatedButton(
                onPressed: null, child: Text("Entrar con correo")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
                },
                child: const Text("Entrar modo de prueba")),
            const Spacer(),
            const Text("Ver. $appVersion"),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
