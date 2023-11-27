import 'package:flutter/material.dart';
import 'package:mi_terra_app/src/back_end/components/global_strings.dart';

class CompletedTasksList extends StatelessWidget {
  const CompletedTasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          title: Text(testUserTask1),
        )
      ],
    );
  }
}
