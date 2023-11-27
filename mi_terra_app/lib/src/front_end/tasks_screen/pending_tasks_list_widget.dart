import 'package:flutter/material.dart';
import 'package:mi_terra_app/src/back_end/components/global_strings.dart';

class PendingTasksList extends StatefulWidget {
  const PendingTasksList({super.key});

  @override
  State<PendingTasksList> createState() => _PendingTasksListState();
}

class _PendingTasksListState extends State<PendingTasksList> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text(testUserTask1),
          trailing: Checkbox(
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value;
                });
              }),
        )
      ],
    );
  }
}
