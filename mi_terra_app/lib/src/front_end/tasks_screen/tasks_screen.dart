import 'package:flutter/material.dart';

enum TaskStatus { pending, completed }

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool? isChecked = false;
  TaskStatus selectedStatus = TaskStatus.pending;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SegmentedButton<TaskStatus>(
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
            ),
          ),
        ],
      ),
      floatingActionButton:
          const FloatingActionButton(onPressed: null, child: Icon(Icons.add)),
    );
  }
}
