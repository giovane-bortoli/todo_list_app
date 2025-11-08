import 'package:flutter/material.dart';
import 'package:todo_list_app/core/routes/app_routes.dart';
import 'package:todo_list_app/core/routes/route_module.dart';
import 'package:todo_list_app/features/todoList/presentation/screens/todo_list_screen.dart';

/// Módulo de rotas da feature Todo
/// Define todas as rotas relacionadas à funcionalidade de tarefas
class TodoRouteModule implements RouteModule {
  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      // Lista de tarefas
      AppRoutes.home: (context) => const TodoListScreen(),
    };
  }

  @override
  Route<dynamic>? generateRoute(RouteSettings settings) {
    // Rotas dinâmicas com parâmetros
    final uri = Uri.parse(settings.name ?? '');

    // Rota: /todo/edit/:id
    if (uri.pathSegments.length == 3 && uri.pathSegments[0] == 'todo' && uri.pathSegments[1] == 'edit') {
      final taskId = uri.pathSegments[2];
      return MaterialPageRoute(
        builder: (context) =>
            _placeholderPage(context, 'Editar Tarefa #$taskId', 'Formulário para editar a tarefa com ID: $taskId'),
        settings: settings,
      );
    }

    // Rota: /todo/details/:id
    if (uri.pathSegments.length == 3 && uri.pathSegments[0] == 'todo' && uri.pathSegments[1] == 'details') {
      final taskId = uri.pathSegments[2];
      return MaterialPageRoute(
        builder: (context) => _placeholderPage(
          context,
          'Detalhes da Tarefa #$taskId',
          'Visualização detalhada da tarefa com ID: $taskId',
        ),
        settings: settings,
      );
    }

    return null;
  }

  /// Widget placeholder até ter mais páginas
  Widget _placeholderPage(BuildContext context, String title, String description) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.construction, size: 64, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 24),
              Text(title, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              Text(description, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.home),
                icon: const Icon(Icons.home),
                label: const Text('Voltar para Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
