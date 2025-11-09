import 'package:get_it/get_it.dart';
import 'package:todo_list_app/core/di/core_dependencies.dart';
import 'package:todo_list_app/core/di/dependency_module.dart';
import 'package:todo_list_app/features/todoList/todo_dependencies.dart';

final sl = GetIt.instance;

class ServiceLocator {
  ServiceLocator._();

  static final List<DependencyModule> _modules = [CoreDependenciesModule(), TodoDependenciesModule()];

  static Future<void> init() async {
    for (final module in _modules) {
      await module.registerDependencies(sl);
    }

    print('✅ ServiceLocator inicializado com ${_modules.length} módulo(s)');
  }

  static Future<void> reset() async {
    await sl.reset();
    print('🔄 ServiceLocator resetado');
  }

  static Future<void> resetAndInit() async {
    await reset();
    await init();
  }
}
