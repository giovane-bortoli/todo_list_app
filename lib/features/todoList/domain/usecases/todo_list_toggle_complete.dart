import 'package:todo_list_app/core/errors/failures.dart';
import 'package:todo_list_app/features/todoList/domain/entities/todo_list_entity.dart';
import 'package:todo_list_app/features/todoList/domain/repository/todo_list_repository.dart';

class TodoListToggleComplete {
  final TodoListRepository repository;

  TodoListToggleComplete({required this.repository});

  Future<(Failure?, TodoListEntity?)> call(String id) async {
    if (id.trim().isEmpty) {
      return (const ValidationFailure(message: 'ID da tarefa é obrigatório'), null);
    }

    return await repository.toggleTodoComplete(id);
  }
}
