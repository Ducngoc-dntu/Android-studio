import '../models/task.dart';
import '../services/task_service.dart';

class TaskController {
  final TaskService _taskService = TaskService();

  Future<List<Task>> fetchTasks() {
    return _taskService.getTasks();
  }

  Future<void> createTask({
    required String title,
    required String description,
    required String status,
    required int priority,
    DateTime? dueDate,
    String? assignedTo, // Thêm tham số này
    required String createdBy,
    String? category,
    List<String>? attachments,
  }) {
    final now = DateTime.now();
    final task = Task(
      id: now.toIso8601String(),
      title: title,
      description: description,
      status: status,
      priority: priority,
      dueDate: dueDate,
      createdAt: now,
      updatedAt: now,
      assignedTo: assignedTo, // Gán ID người dùng
      createdBy: createdBy,
      category: category,
      attachments: attachments,
      completed: status.toLowerCase() == 'done',
    );
    return _taskService.addTask(task);
  }

  Future<void> modifyTask(Task task) {
    final updatedTask = Task(
      id: task.id,
      title: task.title,
      description: task.description,
      status: task.status,
      priority: task.priority,
      dueDate: task.dueDate,
      createdAt: task.createdAt,
      updatedAt: DateTime.now(),
      assignedTo: task.assignedTo, // Cập nhật ID người dùng
      createdBy: task.createdBy,
      category: task.category,
      attachments: task.attachments,
      completed: task.completed,
    );
    return _taskService.updateTask(updatedTask);
  }

  Future<void> removeTask(String id) {
    return _taskService.deleteTask(id);
  }
}