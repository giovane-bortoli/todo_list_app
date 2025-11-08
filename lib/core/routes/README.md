# Sistema de Rotas Modular e Escalável

Sistema de navegação modular para organizar rotas de forma escalável, onde cada feature gerencia suas próprias rotas de forma isolada.

---

## 📂 Estrutura

```
lib/
├── core/
│   └── routes/
│       ├── route_module.dart        # Interface base para módulos de rotas
│       ├── route_manager.dart       # Gerenciador central de rotas
│       ├── app_routes.dart          # Constantes de todas as rotas
│       └── navigation.dart          # Helpers de navegação type-safe
│
├── features/
│   ├── todo/
│   │   ├── todo_routes.dart         # Rotas da feature Todo
│   │   └── presentation/
│   │       └── pages/               # Páginas da feature
│   │
│   ├── auth/
│   │   ├── auth_routes.dart         # Rotas da feature Auth
│   │   └── ...
│   │
│   └── profile/
│       ├── profile_routes.dart      # Rotas da feature Profile
│       └── ...
│
└── app_widget.dart                  # Configuração do MaterialApp
```

---

## 🚀 Como Funciona

### 1. **Interface Base (RouteModule)**

Todas as features implementam esta interface:

```dart
abstract class RouteModule {
  // Rotas estáticas
  Map<String, WidgetBuilder> getRoutes();

  // Rotas dinâmicas (com parâmetros)
  Route<dynamic>? generateRoute(RouteSettings settings);
}
```

### 2. **Constantes de Rotas (AppRoutes)**

Centraliza todas as constantes de rotas do app:

```dart
class AppRoutes {
  static const String initial = '/';
  static const String home = '/home';

  // Todo Feature
  static const String todoList = '/todo';
  static const String todoCreate = '/todo/create';
  static const String todoEdit = '/todo/edit';

  // Auth Feature
  static const String login = '/auth/login';
  static const String register = '/auth/register';
}
```

### 3. **Route Manager (Orquestrador)**

Consolida rotas de todas as features:

```dart
class RouteManager {
  static final List<RouteModule> _modules = [
    TodoRouteModule(),
    AuthRouteModule(),
  ];

  static Map<String, WidgetBuilder> getRoutes() {
    final routes = <String, WidgetBuilder>{
      AppRoutes.initial: (context) => HomePage(),
    };

    for (final module in _modules) {
      routes.addAll(module.getRoutes());
    }

    return routes;
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    for (final module in _modules) {
      final route = module.generateRoute(settings);
      if (route != null) return route;
    }
    return null; // 404
  }
}
```

### 4. **Configuração no MaterialApp**

```dart
MaterialApp(
  initialRoute: AppRoutes.initial,
  routes: RouteManager.getRoutes(),
  onGenerateRoute: RouteManager.onGenerateRoute,
  onUnknownRoute: RouteManager.onUnknownRoute,
)
```

---

## 📝 Como Adicionar uma Nova Feature

### **Passo 1: Adicionar constantes de rotas**

**`lib/core/routes/app_routes.dart`**

```dart
class AppRoutes {
  // ... rotas existentes

  // Sua Feature
  static const String suaFeatureList = '/sua-feature';
  static const String suaFeatureCreate = '/sua-feature/create';
  static const String suaFeatureEdit = '/sua-feature/edit';
}
```

### **Passo 2: Criar módulo de rotas da feature**

**`lib/features/sua_feature/sua_feature_routes.dart`**

```dart
import 'package:flutter/material.dart';
import 'package:todo_list_app/core/routes/app_routes.dart';
import 'package:todo_list_app/core/routes/route_module.dart';
import 'package:todo_list_app/features/sua_feature/presentation/pages/sua_feature_list_page.dart';

class SuaFeatureRouteModule implements RouteModule {
  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      AppRoutes.suaFeatureList: (context) => SuaFeatureListPage(),
      AppRoutes.suaFeatureCreate: (context) => SuaFeatureCreatePage(),
    };
  }

  @override
  Route<dynamic>? generateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '');

    // Rota dinâmica: /sua-feature/edit/:id
    if (uri.pathSegments.length == 3 &&
        uri.pathSegments[0] == 'sua-feature' &&
        uri.pathSegments[1] == 'edit') {
      final id = uri.pathSegments[2];
      return MaterialPageRoute(
        builder: (context) => SuaFeatureEditPage(id: id),
        settings: settings,
      );
    }

    return null;
  }
}
```

### **Passo 3: Registrar no RouteManager**

**`lib/core/routes/route_manager.dart`**

```dart
import 'package:todo_list_app/features/sua_feature/sua_feature_routes.dart';

static final List<RouteModule> _modules = [
  TodoRouteModule(),
  SuaFeatureRouteModule(), // ← Adicionar aqui
];
```

### **Passo 4: Adicionar métodos de navegação (opcional)**

**`lib/core/routes/navigation.dart`**

```dart
// No helper Navigation
static Future<void> toSuaFeatureList(BuildContext context) {
  return push(context, AppRoutes.suaFeatureList);
}

static Future<void> toSuaFeatureEdit(BuildContext context, String id) {
  return push(context, '/sua-feature/edit/$id');
}

// Na extension NavigationExtension
extension NavigationExtension on BuildContext {
  Future<void> toSuaFeatureList() => Navigation.toSuaFeatureList(this);
  Future<void> toSuaFeatureEdit(String id) => Navigation.toSuaFeatureEdit(this, id);
}
```

**Pronto!** As rotas estarão disponíveis em todo o app.

---

## 💡 Usando Navegação

### **Método 1: Via Extension (Recomendado)**

```dart
// Simples e limpo
ElevatedButton(
  onPressed: () => context.toTodoList(),
  child: Text('Lista de Tarefas'),
)

// Com parâmetros
ElevatedButton(
  onPressed: () => context.toTodoEdit('123'),
  child: Text('Editar Tarefa'),
)

// Voltar
ElevatedButton(
  onPressed: () => context.pop(),
  child: Text('Voltar'),
)
```

### **Método 2: Via Helper Navigation**

```dart
ElevatedButton(
  onPressed: () => Navigation.toTodoList(context),
  child: Text('Lista'),
)

// Com resultado
final result = await Navigation.toTodoCreate(context);
if (result != null) {
  print('Tarefa criada: $result');
}
```

### **Método 3: Via Navigator direto**

```dart
// Rotas nomeadas
Navigator.of(context).pushNamed(AppRoutes.todoList);

// Rotas dinâmicas
Navigator.of(context).pushNamed('/todo/edit/123');

// Com argumentos
Navigator.of(context).pushNamed(
  AppRoutes.todoEdit,
  arguments: {'id': '123', 'title': 'Task'},
);
```

---

## 🎯 Tipos de Navegação

### **Push (Adiciona na pilha)**

```dart
context.toTodoList()
// ou
Navigation.push(context, AppRoutes.todoList)
```

### **Push Replacement (Substitui atual)**

```dart
Navigation.pushReplacement(context, AppRoutes.home)
```

### **Push and Remove Until (Limpa pilha)**

```dart
Navigation.pushAndRemoveUntil(context, AppRoutes.home)
// ou
context.toHome(clearStack: true)
```

### **Pop (Volta)**

```dart
context.pop()
// ou
context.pop(result) // Com resultado
```

---

## 🏗️ Exemplo Completo: Feature Todo

### **Rotas Estáticas**

```dart
class TodoRouteModule implements RouteModule {
  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      AppRoutes.todoList: (context) => TodoListPage(),
      AppRoutes.todoCreate: (context) => TodoCreatePage(),
    };
  }
}
```

### **Rotas Dinâmicas (com parâmetros)**

```dart
@override
Route<dynamic>? generateRoute(RouteSettings settings) {
  final uri = Uri.parse(settings.name ?? '');

  // Rota: /todo/edit/:id
  if (uri.pathSegments.length == 3 &&
      uri.pathSegments[0] == 'todo' &&
      uri.pathSegments[1] == 'edit') {
    final taskId = uri.pathSegments[2];
    return MaterialPageRoute(
      builder: (context) => TodoEditPage(taskId: taskId),
      settings: settings,
    );
  }

  return null;
}
```

### **Uso na UI**

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => context.toTodoList(),
            child: Text('Ver Tarefas'),
          ),
          ElevatedButton(
            onPressed: () => context.toTodoCreate(),
            child: Text('Nova Tarefa'),
          ),
          ElevatedButton(
            onPressed: () => context.toTodoEdit('123'),
            child: Text('Editar Tarefa #123'),
          ),
        ],
      ),
    );
  }
}
```

### **Navegação com Resultado**

```dart
// Página de criação
class TodoCreatePage extends StatelessWidget {
  void _onSave(BuildContext context) {
    final newTodo = Todo(id: '123', title: 'Nova Tarefa');
    Navigator.of(context).pop(newTodo); // Retorna resultado
  }
}

// Página que chama
final result = await context.toTodoCreate();
if (result != null) {
  print('Tarefa criada: ${result.title}');
}
```

---

## 🔧 Recursos Avançados

### **1. Transições Customizadas**

```dart
Route<dynamic>? generateRoute(RouteSettings settings) {
  if (settings.name == '/todo/details/123') {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return TodoDetailsPage(id: '123');
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
  return null;
}
```

### **2. Guard de Autenticação**

```dart
static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  // Verificar autenticação antes de acessar rotas protegidas
  if (_isProtectedRoute(settings.name)) {
    final isAuthenticated = sl<AuthService>().isAuthenticated;
    if (!isAuthenticated) {
      return MaterialPageRoute(
        builder: (_) => LoginPage(),
      );
    }
  }

  // Processar normalmente
  for (final module in _modules) {
    final route = module.generateRoute(settings);
    if (route != null) return route;
  }

  return null;
}
```

### **3. Deep Links**

```dart
// Configurar no AndroidManifest.xml e Info.plist

// Processar no app
Route<dynamic>? generateRoute(RouteSettings settings) {
  final uri = Uri.parse(settings.name ?? '');

  // myapp://todo/details/123
  if (uri.scheme == 'myapp' && uri.host == 'todo') {
    final id = uri.pathSegments.last;
    return MaterialPageRoute(
      builder: (context) => TodoDetailsPage(id: id),
    );
  }

  return null;
}
```

### **4. Argumentos Tipados**

```dart
// Definir classe de argumentos
class TodoEditArgs {
  final String taskId;
  final bool isEditMode;

  TodoEditArgs({required this.taskId, required this.isEditMode});
}

// Passar argumentos
Navigator.of(context).pushNamed(
  AppRoutes.todoEdit,
  arguments: TodoEditArgs(taskId: '123', isEditMode: true),
);

// Receber argumentos
class TodoEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as TodoEditArgs;

    return Scaffold(
      appBar: AppBar(title: Text('Editar #${args.taskId}')),
    );
  }
}
```

---

## ✅ Boas Práticas

1. **Use constantes** para nomes de rotas (evita erros de digitação)
2. **Prefixe rotas por feature** (ex: `/todo/...`, `/auth/...`)
3. **Rotas dinâmicas** para parâmetros variáveis (ex: `/todo/edit/:id`)
4. **Rotas estáticas** para páginas fixas (ex: `/todo/create`)
5. **Extensions** para navegação limpa e type-safe
6. **Módulos isolados** - cada feature gerencia suas rotas
7. **Teste rotas** - verifique se todas funcionam corretamente
8. **404 page** - sempre tenha um fallback para rotas não encontradas

---

## 🧪 Testando Rotas

```dart
void main() {
  testWidgets('Deve navegar para lista de tarefas', (tester) async {
    await tester.pumpWidget(MyApp());

    // Toca no botão
    await tester.tap(find.text('Lista de Tarefas'));
    await tester.pumpAndSettle();

    // Verifica se navegou
    expect(find.text('Lista de Tarefas'), findsOneWidget);
  });
}
```

---

## 🎯 Resumo Rápido

```dart
// 1. Criar módulo de rotas
class MinhaFeatureRouteModule implements RouteModule {
  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      '/minha-feature': (context) => MinhaFeaturePage(),
    };
  }

  @override
  Route<dynamic>? generateRoute(RouteSettings settings) {
    // Rotas dinâmicas
    return null;
  }
}

// 2. Registrar no RouteManager
static final List<RouteModule> _modules = [
  MinhaFeatureRouteModule(), // ← Aqui
];

// 3. Navegar
context.pushNamed('/minha-feature');
```

**Pronto! Sistema de rotas modular e escalável.** 🚀
