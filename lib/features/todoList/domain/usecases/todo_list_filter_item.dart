import 'package:todo_list_app/core/errors/failures.dart';
import 'package:todo_list_app/features/todoList/domain/entities/todo_list_entity.dart';
import 'package:todo_list_app/features/todoList/domain/enums/todo_filter_enum.dart';
import 'package:todo_list_app/features/todoList/domain/repository/todo_list_repository.dart';

class TodoListFilterItem {
  final TodoListRepository repository;

  TodoListFilterItem({required this.repository});

  Future<(Failure?, List<TodoListEntity>?)> call(TodoFilterEnum filterType) async {
    final (failure, todos) = await repository.getAllTodos();

    if (failure != null) {
      return (failure, null);
    }

    if (todos == null || todos.isEmpty) {
      return (null, <TodoListEntity>[]);
    }

    final filteredTodos = _applyFilter(todos, filterType);

    return (null, filteredTodos);
  }

  List<TodoListEntity> _applyFilter(List<TodoListEntity> todos, TodoFilterEnum filterType) {
    switch (filterType) {
      case TodoFilterEnum.all:
        return todos;
      case TodoFilterEnum.pending:
        return todos.where((todo) => !todo.isCompleted).toList();
      case TodoFilterEnum.done:
        return todos.where((todo) => todo.isCompleted).toList();
    }
  }
}
