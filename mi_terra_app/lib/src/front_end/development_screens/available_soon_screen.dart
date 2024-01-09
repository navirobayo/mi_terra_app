import 'package:flutter/material.dart';
import 'package:mi_terra_app/src/back_end/components/global_strings.dart';

class AvailableSoonScreen extends StatelessWidget {
  const AvailableSoonScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("$appName $appVersion")),
        body: const Center(
          child: Text("¡Funcionalidad disponible muy pronto!"),
        ));
  }
}
