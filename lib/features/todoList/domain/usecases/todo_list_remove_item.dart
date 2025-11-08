import 'package:todo_list_app/core/errors/failures.dart';
import 'package:todo_list_app/features/todoList/domain/repository/todo_list_repository.dart';

class TodoListRemoveItem {
  final TodoListRepository repository;

  TodoListRemoveItem({required this.repository});

  Future<(Failure?, bool?)> call(String id) async {
    if (id.trim().isEmpty) {
      return (const ValidationFailure(message: 'ID da tarefa é obrigatório'), null);
    }

    return await repository.removeTodo(id);
  }
}
