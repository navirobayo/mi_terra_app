import 'package:flutter/material.dart';

enum TaskStatus { pending, completed }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  TaskStatus selectedStatus = TaskStatus.pending;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<TaskStatus>(
      segments: const <ButtonSegment<TaskStatus>>[
        ButtonSegment<TaskStatus>(
          value: TaskStatus.pending,
          label: Text('Pending'),
        ),
        ButtonSegment<TaskStatus>(
          value: TaskStatus.completed,
          label: Text('Completed'),
        ),
      ],
      selected: <TaskStatus>{selectedStatus},
      onSelectionChanged: (Set<TaskStatus> newSelection) {
        setState(() {
          selectedStatus = newSelection.first;
        });
      },
    );
  }
}
