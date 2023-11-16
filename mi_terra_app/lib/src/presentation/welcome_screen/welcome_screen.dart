import 'package:flutter/material.dart';
import 'package:mi_terra_app/src/presentation/home_screen/home_screen.dart';

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
        child: ListView(
          children: [
            Text("Hola granjero/a"),
            Row(
              children: [
                Text("Oveja Go. Ver 1.0.0"),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                    },
                    icon: Icon(Icons.arrow_forward))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
