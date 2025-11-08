import 'package:get_it/get_it.dart';
import 'package:todo_list_app/core/utils/command.dart';
import 'package:todo_list_app/features/todoList/domain/entities/todo_list_entity.dart';
import 'package:todo_list_app/features/todoList/domain/enums/todo_filter_enum.dart';
import 'package:todo_list_app/features/todoList/domain/usecases/todo_list_add_item.dart';
import 'package:todo_list_app/features/todoList/domain/usecases/todo_list_filter_item.dart';
import 'package:todo_list_app/features/todoList/domain/usecases/todo_list_get_all.dart';
import 'package:todo_list_app/features/todoList/domain/usecases/todo_list_remove_item.dart';
import 'package:todo_list_app/features/todoList/domain/usecases/todo_list_toggle_complete.dart';

class TodoListController {
  final getAllItemUseCase = GetIt.instance<TodoListGetAll>();
  final addItemUseCase = GetIt.instance<TodoListAddItem>();
  final removeItemUseCase = GetIt.instance<TodoListRemoveItem>();
  final toggleCompleteUseCase = GetIt.instance<TodoListToggleComplete>();
  final filterItemUseCase = GetIt.instance<TodoListFilterItem>();

  final todosCommand = Command<List<TodoListEntity>>(data: []);
  final filterCommand = Command<TodoFilterEnum>(data: TodoFilterEnum.all);
  final isLoadingCommand = Command<bool>(data: false);
  final errorCommand = Command<String?>(data: null);

  Future<void> loadTodos() async {
    isLoadingCommand.setData(true);
    errorCommand.setData(null);

    final (failure, todos) = await getAllItemUseCase();

    if (failure != null) {
      errorCommand.setData(failure.message);
      isLoadingCommand.setData(false);
      return;
    }

    todosCommand.setData(todos ?? []);
    isLoadingCommand.setData(false);
    applyFilter(filterCommand.data);
  }

  void applyFilter(TodoFilterEnum filter) async {
    filterCommand.setData(filter);
    isLoadingCommand.setData(true);

    final (failure, filteredTodos) = await filterItemUseCase(filter);

    if (failure != null) {
      errorCommand.setData(failure.message);
      isLoadingCommand.setData(false);
      return;
    }

    todosCommand.setData(filteredTodos ?? []);
    isLoadingCommand.setData(false);
  }

  Future<void> toggleTodoComplete(String id) async {
    final (failure, updatedTodo) = await toggleCompleteUseCase(id);

    if (failure != null) {
      errorCommand.setData(failure.message);
      return;
    }

    await loadTodos();
  }

  Future<void> addTodo(TodoListEntity todo) async {
    isLoadingCommand.setData(true);

    final (failure, addedTodo) = await addItemUseCase(todo);

    if (failure != null) {
      errorCommand.setData(failure.message);
      isLoadingCommand.setData(false);
      return;
    }

    await loadTodos();
  }

  Future<void> removeTodo(String id) async {
    final (failure, _) = await removeItemUseCase(id);

    if (failure != null) {
      errorCommand.setData(failure.message);
      return;
    }

    await loadTodos();
  }

  void dispose() {
    todosCommand.dispose();
    filterCommand.dispose();
    isLoadingCommand.dispose();
    errorCommand.dispose();
  }
}
