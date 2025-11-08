# Sistema de Dependency Injection com GetIt

Sistema modular e escalável de injeção de dependências para organizar o código seguindo os princípios de Clean Architecture.

---

## 📂 Estrutura

```
lib/
├── core/
│   └── di/
│       ├── dependency_module.dart     # Interface base para módulos
│       ├── service_locator.dart       # Setup principal do GetIt
│       └── core_dependencies.dart     # Dependências compartilhadas
│
├── features/
│   ├── todo/
│   │   ├── todo_dependencies.dart     # Dependências da feature Todo
│   │   ├── data/                      # Repositories, DataSources, Models
│   │   ├── domain/                    # Entities, UseCases, Interfaces
│   │   └── presentation/              # Controllers, Pages, Widgets
│   │
│   ├── auth/
│   │   ├── auth_dependencies.dart     # Dependências da feature Auth
│   │   └── ...
│   │
│   └── profile/
│       ├── profile_dependencies.dart  # Dependências da feature Profile
│       └── ...
│
└── main.dart
```

---

## 🚀 Como Funciona

### 1. **Interface Base (DependencyModule)**

Todas as features implementam esta interface:

```dart
abstract class DependencyModule {
  Future<void> registerDependencies(GetIt sl);
}
```

### 2. **Service Locator (Orquestrador)**

O `service_locator.dart` coordena o registro de todos os módulos:

```dart
final sl = GetIt.instance; // Singleton global

class ServiceLocator {
  static final List<DependencyModule> _modules = [
    CoreDependenciesModule(),    // Core
    TodoDependenciesModule(),    // Feature
    AuthDependenciesModule(),    // Feature
  ];

  static Future<void> init() async {
    for (final module in _modules) {
      await module.registerDependencies(sl);
    }
  }
}
```

### 3. **Inicialização no main.dart**

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.init(); // Registra tudo antes do app
  runApp(MyApp());
}
```

---

## 📝 Como Adicionar uma Nova Feature

### **Passo 1: Criar a estrutura da feature**

```
lib/features/sua_feature/
├── sua_feature_dependencies.dart
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── controllers/
    ├── pages/
    └── widgets/
```

### **Passo 2: Criar o módulo de dependências**

**`lib/features/sua_feature/sua_feature_dependencies.dart`**

```dart
import 'package:get_it/get_it.dart';
import 'package:todo_list_app/core/di/dependency_module.dart';

class SuaFeatureDependenciesModule implements DependencyModule {
  @override
  Future<void> registerDependencies(GetIt sl) async {
    // ===== DATA LAYER =====
    sl.registerLazySingleton<SuaFeatureLocalDataSource>(
      () => SuaFeatureLocalDataSourceImpl(sl()),
    );

    sl.registerLazySingleton<SuaFeatureRepository>(
      () => SuaFeatureRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
      ),
    );

    // ===== DOMAIN LAYER =====
    sl.registerLazySingleton(() => GetSuaFeatureUseCase(sl()));
    sl.registerLazySingleton(() => CreateSuaFeatureUseCase(sl()));

    // ===== PRESENTATION LAYER =====
    sl.registerFactory(() => SuaFeatureBloc(
      getSuaFeature: sl(),
      createSuaFeature: sl(),
    ));

    print('  ✓ SuaFeature module dependencies registered');
  }
}
```

### **Passo 3: Registrar no ServiceLocator**

**`lib/core/di/service_locator.dart`**

```dart
import 'package:todo_list_app/features/sua_feature/sua_feature_dependencies.dart';

static final List<DependencyModule> _modules = [
  CoreDependenciesModule(),
  TodoDependenciesModule(),
  SuaFeatureDependenciesModule(), // ← Adicionar aqui
];
```

**Pronto!** Suas dependências serão registradas automaticamente ao iniciar o app.

---

## 🎯 Tipos de Registro GetIt

### **Singleton (Lazy)**

Uma única instância criada quando solicitada pela primeira vez:

```dart
sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
```

### **Singleton (Eager)**

Uma única instância criada imediatamente:

```dart
sl.registerSingleton<SharedPreferences>(sharedPreferences);
```

### **Factory**

Nova instância criada toda vez que for solicitada:

```dart
sl.registerFactory(() => TodoBloc(getTodos: sl()));
```

---

## 💡 Usando as Dependências

### **1. No Controller/Bloc/Cubit**

```dart
import 'package:todo_list_app/core/di/service_locator.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtém a dependência registrada
    final bloc = sl<TodoBloc>();

    return BlocProvider.value(
      value: bloc,
      child: TodoView(),
    );
  }
}
```

### **2. Via Construtor (Recomendado)**

```dart
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodosUseCase getTodos;
  final CreateTodoUseCase createTodo;

  TodoBloc({
    required this.getTodos,
    required this.createTodo,
  }) : super(TodoInitial());
}

// Registro
sl.registerFactory(() => TodoBloc(
  getTodos: sl(),    // GetIt resolve automaticamente
  createTodo: sl(),
));
```

---

## 🏗️ Exemplo Completo: Feature Todo

### **Core Dependencies**

```dart
class CoreDependenciesModule implements DependencyModule {
  @override
  Future<void> registerDependencies(GetIt sl) async {
    // HTTP Client
    sl.registerLazySingleton<Dio>(() {
      final dio = Dio();
      dio.options.baseUrl = 'https://api.example.com';
      return dio;
    });

    // Storage
    final prefs = await SharedPreferences.getInstance();
    sl.registerSingleton<SharedPreferences>(prefs);

    sl.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    );

    // Utils
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  }
}
```

### **Todo Dependencies**

```dart
class TodoDependenciesModule implements DependencyModule {
  @override
  Future<void> registerDependencies(GetIt sl) async {
    // Data Sources
    sl.registerLazySingleton<TodoLocalDataSource>(
      () => TodoLocalDataSourceImpl(storage: sl()),
    );

    sl.registerLazySingleton<TodoRemoteDataSource>(
      () => TodoRemoteDataSourceImpl(client: sl()),
    );

    // Repository
    sl.registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
        networkInfo: sl(),
      ),
    );

    // Use Cases
    sl.registerLazySingleton(() => GetTodosUseCase(sl()));
    sl.registerLazySingleton(() => CreateTodoUseCase(sl()));
    sl.registerLazySingleton(() => UpdateTodoUseCase(sl()));
    sl.registerLazySingleton(() => DeleteTodoUseCase(sl()));

    // Bloc
    sl.registerFactory(() => TodoBloc(
      getTodos: sl(),
      createTodo: sl(),
      updateTodo: sl(),
      deleteTodo: sl(),
    ));
  }
}
```

### **Uso na UI**

```dart
class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TodoBloc>()..add(LoadTodos()),
      child: Scaffold(
        appBar: AppBar(title: Text('To-Do List')),
        body: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoading) {
              return CircularProgressIndicator();
            }
            if (state is TodoLoaded) {
              return ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (context, index) {
                  return TodoItem(todo: state.todos[index]);
                },
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
```

---

## 🧪 Testes

### **Resetar Dependências entre Testes**

```dart
void main() {
  setUp(() async {
    await ServiceLocator.reset();
    await ServiceLocator.init();
  });

  test('Deve criar uma tarefa', () async {
    final useCase = sl<CreateTodoUseCase>();
    final result = await useCase(TodoParams(title: 'Test'));
    expect(result.isRight(), true);
  });
}
```

### **Mock de Dependências**

```dart
void main() {
  late MockTodoRepository mockRepository;

  setUp(() {
    mockRepository = MockTodoRepository();

    // Sobrescreve o registro real com o mock
    sl.registerLazySingleton<TodoRepository>(() => mockRepository);
  });

  test('Deve retornar lista de tarefas', () async {
    when(() => mockRepository.getTodos())
        .thenAnswer((_) async => Right([TodoEntity(id: '1', title: 'Test')]));

    final bloc = sl<TodoBloc>();
    bloc.add(LoadTodos());

    await expectLater(
      bloc.stream,
      emitsInOrder([TodoLoading(), TodoLoaded(todos: [/* ... */])]),
    );
  });
}
```

---

## ✅ Boas Práticas

1. **Uma feature = Um módulo de dependências**
2. **Registre no ServiceLocator na ordem correta** (Core → Features)
3. **Use `registerFactory` para Blocs/Controllers** (nova instância por página)
4. **Use `registerLazySingleton` para Repositories/UseCases** (reutilizar)
5. **Use `registerSingleton` apenas para objetos já instanciados** (ex: SharedPreferences)
6. **Mantenha as dependências explícitas via construtor** (facilita testes)
7. **Documente dependências complexas** com comentários

---

## 🔧 Comandos Úteis

### **Verificar Dependências Registradas**

```dart
print(sl.allReady()); // true se tudo foi registrado
```

### **Resetar Tudo**

```dart
await ServiceLocator.reset();
```

### **Reinicializar**

```dart
await ServiceLocator.resetAndInit();
```

---

## 📚 Recursos

- [GetIt Documentation](https://pub.dev/packages/get_it)
- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Dependency Injection Best Practices](https://flutter.dev/docs/development/data-and-backend/state-mgmt/options#service-locator)

---

## 🎯 Resumo Rápido

```dart
// 1. Criar módulo
class MinhaFeatureDependenciesModule implements DependencyModule {
  @override
  Future<void> registerDependencies(GetIt sl) async {
    sl.registerLazySingleton<MinhaFeatureRepository>(() => ...);
    sl.registerFactory(() => MinhaFeatureBloc(...));
  }
}

// 2. Adicionar no ServiceLocator
static final List<DependencyModule> _modules = [
  MinhaFeatureDependenciesModule(), // ← Aqui
];

// 3. Usar no código
final bloc = sl<MinhaFeatureBloc>();
```

**Pronto! Sistema escalável e organizado.** 🚀
