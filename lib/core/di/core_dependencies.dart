import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/core/di/dependency_module.dart';

class CoreDependenciesModule implements DependencyModule {
  @override
  Future<void> registerDependencies(GetIt sl) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  }
}
