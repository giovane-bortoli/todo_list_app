import 'package:todo_list_app/core/errors/exceptions.dart';
import 'package:todo_list_app/core/utils/cache_manager.dart';
import 'package:todo_list_app/features/todoList/data/datasource/todo_list_local_datasource.dart';
import 'package:todo_list_app/features/todoList/data/models/todo_list_model.dart';

/// Implementação concreta do DataSource usando SharedPreferences
/// Responsável por toda lógica de persistência local de tarefas
/// Usa CacheManager para encapsular operações de cache
class TodoListLocalDataSourceImpl implements TodoListLocalDataSource {
  final CacheManager cacheManager;

  static const String _todosKey = 'CACHED_TODOS';

  TodoListLocalDataSourceImpl({required this.cacheManager});

  @override
  Future<List<TodoListModel>> getAllTodos() async {
    try {
      return cacheManager.getList<TodoListModel>(_todosKey, TodoListModel.fromMap);
    } catch (e) {
      throw CacheException(message: 'Erro ao buscar tarefas: ${e.toString()}');
    }
  }

  @override
  Future<TodoListModel> addTodo(TodoListModel todo) async {
    try {
      final currentTodos = await getAllTodos();
      currentTodos.add(todo);
      await _saveTodos(currentTodos);
      return todo;
    } catch (e) {
      throw CacheException(message: 'Erro ao adicionar tarefa: ${e.toString()}');
    }
  }

  @override
  Future<bool> removeTodo(String id) async {
    try {
      final currentTodos = await getAllTodos();

      final todoExists = currentTodos.any((todo) => todo.id == id);
      if (!todoExists) {
        throw CacheException(message: 'Tarefa com ID $id não encontrada');
      }

      currentTodos.removeWhere((todo) => todo.id == id);
      await _saveTodos(currentTodos);

      return true;
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(message: 'Erro ao remover tarefa: ${e.toString()}');
    }
  }

  @override
  Future<TodoListModel> toggleTodoComplete(String id) async {
    try {
      final currentTodos = await getAllTodos();

      final todoIndex = currentTodos.indexWhere((todo) => todo.id == id);

      if (todoIndex == -1) {
        throw CacheException(message: 'Tarefa com ID $id não encontrada');
      }

      final updatedTodo = currentTodos[todoIndex].copyWith(isCompleted: !currentTodos[todoIndex].isCompleted);

      currentTodos[todoIndex] = updatedTodo;
      await _saveTodos(currentTodos);

      return updatedTodo;
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(message: 'Erro ao alternar status da tarefa: ${e.toString()}');
    }
  }

  @override
  Future<TodoListModel?> getTodoById(String id) async {
    try {
      final todos = await getAllTodos();
      final todo = todos.where((todo) => todo.id == id).firstOrNull;
      return todo;
    } catch (e) {
      throw CacheException(message: 'Erro ao buscar tarefa por ID: ${e.toString()}');
    }
  }

  Future<void> _saveTodos(List<TodoListModel> todos) async {
    try {
      await cacheManager.saveList<TodoListModel>(_todosKey, todos, (todo) => todo.toMap());
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(message: 'Erro ao salvar tarefas: ${e.toString()}');
    }
  }
}
