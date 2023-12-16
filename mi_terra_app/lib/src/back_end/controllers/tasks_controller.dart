import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_terra_app/src/back_end/repositories/user_repository.dart';
import 'package:mi_terra_app/src/front_end/tasks_screen/tasks_screen.dart';

class TasksController extends GetxController {
  static TasksController get instance => Get.find();

  TextEditingController taskNote = TextEditingController();

  RxList<String> pendingTasks = <String>[].obs;
  RxList<String> completedTasks = <String>[].obs;

  Future<void> createTask() async {
    final String taskNoteValue = taskNote.text;
    try {
      await UserRepository.instance.saveTask(taskNoteValue);
      Get.snackbar('Perfecto', 'Nueva tarea añadida');
    } catch (error) {
      Get.snackbar('Ups', 'No se ha podido guardar esta tarea: $error');
      print("error: $error");
    }
  }

  void completeTask(int index) async {
    final String completedTask = pendingTasks[index];
    completedTasks.add(completedTask);
    pendingTasks.removeAt(index);

    try {
      await UserRepository.instance.completeTask(completedTask);
      Get.snackbar('Genial', 'Has completado esta tarea');
    } catch (error) {
      Get.snackbar('Ups', 'No se ha podido guardar esta tarea: $error');
      print("error: $error");
    }
  }

  Future<void> loadPendingTasks() async {
    try {
      pendingTasks.assignAll(await UserRepository.instance.loadPendingTasks());
    } catch (error) {
      print("Error loading pending tasks: $error");
    }
  }

  Future<void> loadCompletedTasks() async {
    try {
      completedTasks
          .assignAll(await UserRepository.instance.loadCompletedTasks());
    } catch (error) {
      print("Error loading completed tasks: $error");
    }
  }

  void deleteTask(int index, TaskStatus taskStatus) {
    final List<String> tasksToDelete =
        taskStatus == TaskStatus.pending ? pendingTasks : completedTasks;

    if (index >= 0 && index < tasksToDelete.length) {
      tasksToDelete.removeAt(index);

      final List<String> tasksToUpdate =
          taskStatus == TaskStatus.pending ? completedTasks : pendingTasks;

      UserRepository.instance.updateTasks(
          taskStatus == TaskStatus.pending ? 'tasks.to_do' : 'tasks.completed',
          tasksToUpdate);
    }
  }
}
