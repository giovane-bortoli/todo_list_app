import 'package:todo_list_app/core/errors/failures.dart';
import 'package:todo_list_app/features/todoList/domain/entities/todo_list_entity.dart';
import 'package:todo_list_app/features/todoList/domain/repository/todo_list_repository.dart';

class TodoListAddItem {
  final TodoListRepository repository;

  TodoListAddItem({required this.repository});

  Future<(Failure?, TodoListEntity?)> call(TodoListEntity todo) async {
    if (todo.title.trim().isEmpty) {
      return (const ValidationFailure(message: 'O título da tarefa não pode estar vazio'), null);
    }

    if (todo.title.length < 3) {
      return (const ValidationFailure(message: 'O título deve ter pelo menos 3 caracteres'), null);
    }

    return await repository.addTodo(todo);
  }
}
