import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/controllers/expense_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/external_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/general_expense_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/getx_network_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/inventory_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/network_binding.dart';
import 'package:mi_terra_app/src/back_end/controllers/product_units_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/radio_button_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/get_contacts_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/product_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/get_products_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/sale_controller.dart';
import 'package:mi_terra_app/src/back_end/controllers/tasks_controller.dart';
import 'package:mi_terra_app/src/back_end/repositories/authentication_repository.dart';
import 'package:mi_terra_app/src/back_end/components/flutter_mi_terra_theme.dart';
import 'package:mi_terra_app/src/back_end/repositories/user_repository.dart';
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

Future<void> initializeDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthenticationRepository());
  Get.put(UserRepository());
  Get.put(ProductsController());
  Get.put(ProductController());
  Get.put(ContactsController());
  Get.put(ButtonController());
  Get.put(SaleController());
  Get.put(ExpenseController());
  Get.put(TasksController());
  Get.put(ConnectionManagerController());
  Get.put(InventoryController());
  Get.put(ProductUnitsController());
  Get.put(ExternalController());
  Get.put(GeneralExpenseController());
}

// The main function of the app.
void main() async {
  // Initialize dependencies before running the app
  await initializeDependencies();

  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinding(),
      title: 'Mi Terra App 1.0.0',
      theme: FlutterMiTerraTheme.lightTheme,
      defaultTransition: Transition.leftToRightWithFade,
      darkTheme: FlutterMiTerraTheme.darkTheme,
      home: const CircularProgressIndicator(),
    );
  }
}
