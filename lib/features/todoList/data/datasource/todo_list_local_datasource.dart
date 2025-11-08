import 'package:todo_list_app/features/todoList/data/models/todo_list_model.dart';

/// Interface abstrata para o DataSource local
/// Define o contrato para operações de armazenamento local
/// Permite trocar implementação (SharedPreferences, Hive, SQLite) sem afetar outras camadas
abstract class TodoListLocalDataSource {
  /// Retorna todas as tarefas do armazenamento local
  Future<List<TodoListModel>> getAllTodos();

  /// Salva uma nova tarefa no armazenamento local
  Future<TodoListModel> addTodo(TodoListModel todo);

  /// Remove uma tarefa do armazenamento local pelo ID
  Future<bool> removeTodo(String id);

  /// Alterna o status de completado de uma tarefa
  Future<TodoListModel> toggleTodoComplete(String id);

  /// Busca uma tarefa pelo ID
  Future<TodoListModel?> getTodoById(String id);
}
