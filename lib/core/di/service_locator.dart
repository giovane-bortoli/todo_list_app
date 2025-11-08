import 'package:get_it/get_it.dart';
import 'package:todo_list_app/core/di/core_dependencies.dart';
import 'package:todo_list_app/core/di/dependency_module.dart';
import 'package:todo_list_app/features/todoList/todo_dependencies.dart';

/// Service Locator global da aplicação
/// Singleton responsável por gerenciar todas as dependências
final sl = GetIt.instance;

/// Classe responsável por inicializar e configurar o sistema de DI
/// Registra módulos de dependências de forma modular e escalável
class ServiceLocator {
  ServiceLocator._();

  /// Lista de módulos de dependências a serem registrados
  /// Adicione aqui os módulos de cada feature
  static final List<DependencyModule> _modules = [
    // ===== CORE MODULES =====
    CoreDependenciesModule(), // Dependências do core (network, storage, etc)
    // ===== FEATURE MODULES =====
    // Adicione aqui os módulos das features conforme forem criadas
    TodoDependenciesModule(), // Exemplo: feature de tarefas
    // AuthDependenciesModule(),
    // ProfileDependenciesModule(),
  ];

  /// Inicializa todas as dependências da aplicação
  /// Deve ser chamado antes do runApp() no main.dart
  ///
  /// Exemplo:
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await ServiceLocator.init();
  ///   runApp(MyApp());
  /// }
  /// ```
  static Future<void> init() async {
    // Registra dependências de cada módulo em ordem
    for (final module in _modules) {
      await module.registerDependencies(sl);
    }

    // Log de sucesso (pode ser removido em produção)
    print('✅ ServiceLocator inicializado com ${_modules.length} módulo(s)');
  }

  /// Reseta todas as dependências registradas
  /// Útil para testes ou reinicialização completa do app
  static Future<void> reset() async {
    await sl.reset();
    print('🔄 ServiceLocator resetado');
  }

  /// Reseta e reinicializa todas as dependências
  /// Útil para testes ou quando precisar recarregar tudo
  static Future<void> resetAndInit() async {
    await reset();
    await init();
  }
}
