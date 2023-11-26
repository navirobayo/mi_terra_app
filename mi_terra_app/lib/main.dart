import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/authentication_repository.dart';
import 'package:mi_terra_app/src/components/flutter_mi_terra_theme.dart';
import 'package:mi_terra_app/src/front_end/welcome_screen/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/private/firebase_options.dart';

//* Welcome. Mi Terra App Ver. 1.0.0
//
// This app is my solution to grow food and have
// all the information required for that process directly
// in a mobile device.
//
// My intent is to avoid paper during all the process
// of growing organic food in a piece of land.
//
// The app is designed for Spanish speakers only,
// however the code is written in English
// since I understand it better that way.

// This app should allow the user
// to grow his/her own food and make profits with it.

// Enjoy this organized spagetti code!

//! The app starts here.

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthenticationRepository()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi Terra App 1.0.0',
      theme: FlutterMiTerraTheme.lightTheme,
      defaultTransition: Transition.leftToRightWithFade,
      darkTheme: FlutterMiTerraTheme.darkTheme,
      home: const CircularProgressIndicator(),
    );
  }
}
