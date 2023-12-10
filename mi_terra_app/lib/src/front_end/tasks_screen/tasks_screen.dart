import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/controllers/tasks_controller.dart';
import 'package:mi_terra_app/src/back_end/repositories/user_repository.dart';
import 'package:mi_terra_app/src/front_end/home_screen/home_screen.dart';

enum TaskStatus { pending, completed }

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool? isChecked = false;
  TaskStatus selectedStatus = TaskStatus.pending;
  Future<void> createNewTask(BuildContext context) async {
    final TasksController tasksController = Get.find<TasksController>();
    final formKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Por hacer"),
            content: SingleChildScrollView(
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Nueva tarea pendiente",
                        ),
                        controller: tasksController.taskNote,
                      ),
                      TextButton(
                          onPressed: () {
                            tasksController.createTask();
                            Get.offAll(const HomeScreen());
                          },
                          child: const Text("Crear tarea")),
                    ],
                  )),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      final tasksController = Get.find<TasksController>();
      tasksController.pendingTasks
          .assignAll(await UserRepository.instance.loadPendingTasks());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SegmentedButton<TaskStatus>(
              segments: const <ButtonSegment<TaskStatus>>[
                ButtonSegment<TaskStatus>(
                  value: TaskStatus.pending,
                  label: Text('Pendiente'),
                ),
                ButtonSegment<TaskStatus>(
                  value: TaskStatus.completed,
                  label: Text('Completado'),
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
          Expanded(
            child: Obx(() {
              final tasksController = Get.find<TasksController>();
              final List<String> tasks = selectedStatus == TaskStatus.pending
                  ? tasksController.pendingTasks
                  : []; // Use only pending tasks for "Pendientes" tab
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: const ElevatedButton(
                        onPressed: null, child: Icon(Icons.done)),
                    title: Text(tasks[index]),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            createNewTask(context);
          },
          child: const Icon(Icons.add)),
    );
  }
}
