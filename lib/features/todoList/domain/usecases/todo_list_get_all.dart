import 'package:todo_list_app/core/errors/failures.dart';
import 'package:todo_list_app/features/todoList/domain/entities/todo_list_entity.dart';
import 'package:todo_list_app/features/todoList/domain/repository/todo_list_repository.dart';

class TodoListGetAll {
  final TodoListRepository repository;

  TodoListGetAll({required this.repository});

  Future<(Failure?, List<TodoListEntity>?)> call() async {
    return await repository.getAllTodos();
  }
}
