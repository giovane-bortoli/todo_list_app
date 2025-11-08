import 'package:todo_list_app/core/errors/failures.dart';
import 'package:todo_list_app/features/todoList/domain/entities/todo_list_entity.dart';

abstract class TodoListRepository {
  Future<(Failure?, List<TodoListEntity>?)> getAllTodos();

  Future<(Failure?, TodoListEntity?)> addTodo(TodoListEntity todo);

  Future<(Failure?, bool?)> removeTodo(String id);

  Future<(Failure?, TodoListEntity?)> toggleTodoComplete(String id);
}
