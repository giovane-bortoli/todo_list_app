import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/core/di/dependency_module.dart';
import 'package:todo_list_app/core/utils/cache_manager.dart';
import 'package:todo_list_app/features/todoList/data/datasource/todo_list_local_datasource.dart';
import 'package:todo_list_app/features/todoList/data/datasource/todo_list_local_datasource_impl.dart';
import 'package:todo_list_app/features/todoList/data/repository/todo_list_repository_impl.dart';
import 'package:todo_list_app/features/todoList/domain/repository/todo_list_repository.dart';
import 'package:todo_list_app/features/todoList/domain/usecases/todo_list_add_item.dart';
import 'package:todo_list_app/features/todoList/domain/usecases/todo_list_filter_item.dart';
import 'package:todo_list_app/features/todoList/domain/usecases/todo_list_get_all.dart';
import 'package:todo_list_app/features/todoList/domain/usecases/todo_list_remove_item.dart';
import 'package:todo_list_app/features/todoList/domain/usecases/todo_list_toggle_complete.dart';
import 'package:todo_list_app/features/todoList/presentation/controller/todo_list_controller.dart';

class TodoDependenciesModule implements DependencyModule {
  @override
  Future<void> registerDependencies(GetIt sl) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

    sl.registerLazySingleton<CacheManager>(() => CacheManager(sl()));

    sl.registerLazySingleton<TodoListLocalDataSource>(() => TodoListLocalDataSourceImpl(cacheManager: sl()));

    sl.registerLazySingleton<TodoListRepository>(() => TodoListRepositoryImpl(localDataSource: sl()));

    sl.registerLazySingleton(() => TodoListGetAll(repository: sl()));
    sl.registerLazySingleton(() => TodoListAddItem(repository: sl()));
    sl.registerLazySingleton(() => TodoListRemoveItem(repository: sl()));
    sl.registerLazySingleton(() => TodoListToggleComplete(repository: sl()));
    sl.registerLazySingleton(() => TodoListFilterItem(repository: sl()));

    sl.registerFactory(() => TodoListController());
  }
}
