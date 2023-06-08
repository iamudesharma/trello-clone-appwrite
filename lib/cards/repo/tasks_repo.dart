import '../../model/card_model.dart';

abstract class ITaskRepo {
  Future createTask(Task taskModel);
  Future<List<Task>>? getTasks({required String id});
  Future getTask(String taskId);
  Future deleteTask(String taskId);
  Future<void> updateTask(String taskId, Task taskModel);
}
