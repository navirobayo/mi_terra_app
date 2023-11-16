import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_terra_app/src/persistence/flutter_oveja_go_theme.dart';
import 'package:mi_terra_app/src/presentation/welcome_screen/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Oveja Go 1.0.0',
      theme: FlutterOvejaGoTheme.lightTheme,
      darkTheme: FlutterOvejaGoTheme.darkTheme,
      home: const WelcomeScreen(),
    );
  }
}
