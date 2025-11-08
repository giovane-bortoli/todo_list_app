import 'package:flutter/material.dart';
import 'package:todo_list_app/core/routes/app_routes.dart';
import 'package:todo_list_app/core/routes/route_module.dart';
import 'package:todo_list_app/features/todoList/presentation/screens/todo_list_screen.dart';
import 'package:todo_list_app/features/todoList/todo_routes.dart';

/// Gerenciador central de rotas do aplicativo
/// Consolida todas as rotas de todas as features em um único lugar
class RouteManager {
  RouteManager._();

  /// Lista de módulos de rotas a serem registrados
  /// Adicione aqui os módulos de rotas de cada feature
  static final List<RouteModule> _modules = [
    // ===== FEATURE MODULES =====
    // Adicione aqui os módulos de rotas das features
    TodoRouteModule(), // Exemplo: feature de tarefas
    // AuthRouteModule(),
    // ProfileRouteModule(),
  ];

  /// Retorna o mapa consolidado de todas as rotas do app
  /// Combina rotas principais + rotas de todas as features
  static Map<String, WidgetBuilder> getRoutes() {
    final routes = <String, WidgetBuilder>{
      // ===== ROTAS PRINCIPAIS =====
      AppRoutes.home: (context) => const TodoListScreen(),
    };

    // Adiciona rotas de cada módulo
    for (final module in _modules) {
      routes.addAll(module.getRoutes());
    }

    return routes;
  }

  /// Gerador de rotas dinâmicas
  /// Delega para os módulos de features quando necessário
  /// Usado para rotas com parâmetros e rotas não encontradas
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // Tenta gerar rota em cada módulo
    for (final module in _modules) {
      final route = module.generateRoute(settings);
      if (route != null) return route;
    }

    // Rota não encontrada - retorna página de erro 404
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Erro 404')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Página não encontrada', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('A rota "${settings.name}" não existe.', style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.home),
                child: const Text('Voltar para Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Handler para rotas desconhecidas
  /// Usado quando onGenerateRoute retorna null
  static Route<dynamic>? onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Erro')),
        body: Center(child: Text('Rota desconhecida: ${settings.name}')),
      ),
    );
  }
}
