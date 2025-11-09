import 'package:todo_list_app/features/todoList/data/models/todo_list_model.dart';

abstract class TodoListLocalDataSource {
  Future<List<TodoListModel>> getAllTodos();

  Future<TodoListModel> addTodo(TodoListModel todo);

  Future<bool> removeTodo(String id);

  Future<TodoListModel> toggleTodoComplete(String id);

  Future<TodoListModel?> getTodoById(String id);
}
