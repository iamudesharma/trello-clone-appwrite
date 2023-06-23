import '../../model/card_model.dart';

abstract class ITaskRepo {
  Future createTask(Task taskModel);
  Future<List<Task>>? getTasks({
    required String boardId,
  });
  Future getTask(String taskId);
  Future deleteTask(String taskId);
  Future<void> updateTask(String taskId, Task taskModel);
}

class TaskRepo extends ITaskRepo {
  @override
  Future createTask(Task taskModel) {
    // TODO: implement createTask
    throw UnimplementedError();
  }

  @override
  Future deleteTask(String taskId) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future getTask(String taskId) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>>? getTasks({
    required String boardId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(String taskId, Task taskModel) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
