import 'package:todo_list_app/core/errors/exceptions.dart';
import 'package:todo_list_app/core/errors/failures.dart';
import 'package:todo_list_app/features/todoList/data/datasource/todo_list_local_datasource.dart';
import 'package:todo_list_app/features/todoList/data/models/todo_list_model.dart';
import 'package:todo_list_app/features/todoList/domain/entities/todo_list_entity.dart';
import 'package:todo_list_app/features/todoList/domain/repository/todo_list_repository.dart';

class TodoListRepositoryImpl implements TodoListRepository {
  final TodoListLocalDataSource localDataSource;

  TodoListRepositoryImpl({required this.localDataSource});

  @override
  Future<(Failure?, List<TodoListEntity>?)> getAllTodos() async {
    try {
      final todosModel = await localDataSource.getAllTodos();

      final todosEntity = todosModel.map((model) => model.toEntity()).toList();

      return (null, todosEntity);
    } on CacheException catch (e) {
      return (CacheFailure(message: e.message, code: e.code), null);
    } catch (e) {
      return (UnknownFailure(message: 'Erro desconhecido ao buscar tarefas: ${e.toString()}'), null);
    }
  }

  @override
  Future<(Failure?, TodoListEntity?)> addTodo(TodoListEntity todo) async {
    try {
      final todoModel = TodoListModel.fromEntity(todo);

      final addedTodoModel = await localDataSource.addTodo(todoModel);

      final addedTodoEntity = addedTodoModel.toEntity();

      return (null, addedTodoEntity);
    } on CacheException catch (e) {
      return (CacheFailure(message: e.message, code: e.code), null);
    } catch (e) {
      return (UnknownFailure(message: 'Erro desconhecido ao adicionar tarefa: ${e.toString()}'), null);
    }
  }

  @override
  Future<(Failure?, bool?)> removeTodo(String id) async {
    try {
      final success = await localDataSource.removeTodo(id);
      return (null, success);
    } on CacheException catch (e) {
      return (CacheFailure(message: e.message, code: e.code), null);
    } catch (e) {
      return (UnknownFailure(message: 'Erro desconhecido ao remover tarefa: ${e.toString()}'), null);
    }
  }

  @override
  Future<(Failure?, TodoListEntity?)> toggleTodoComplete(String id) async {
    try {
      final updatedTodoModel = await localDataSource.toggleTodoComplete(id);

      final updatedTodoEntity = updatedTodoModel.toEntity();

      return (null, updatedTodoEntity);
    } on CacheException catch (e) {
      return (CacheFailure(message: e.message, code: e.code), null);
    } catch (e) {
      return (UnknownFailure(message: 'Erro desconhecido ao alternar status: ${e.toString()}'), null);
    }
  }
}
