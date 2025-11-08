# CacheManager - Gerenciador Customizado de Cache

Wrapper type-safe e robusto sobre o SharedPreferences que simplifica operações de cache e reduz duplicação de código.

---

## 🎯 Objetivo

Encapsular operações do SharedPreferences fornecendo:

- ✅ Métodos type-safe para diferentes tipos de dados
- ✅ Conversão automática JSON ↔ Objetos
- ✅ Tratamento de erros consistente
- ✅ Código mais limpo nos DataSources

---

## 📦 Localização

```
lib/core/utils/cache_manager.dart
```

---

## 🚀 Uso Básico

### **1. Registro no DI**

```dart
// Em todo_dependencies.dart ou core_dependencies.dart
final sharedPreferences = await SharedPreferences.getInstance();
sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

sl.registerLazySingleton<CacheManager>(() => CacheManager(sl()));
```

### **2. Injeção no DataSource**

```dart
class TodoListLocalDataSourceImpl implements TodoListLocalDataSource {
  final CacheManager cacheManager;

  TodoListLocalDataSourceImpl({required this.cacheManager});
}
```

---

## 📝 Métodos Disponíveis

### **Strings**

```dart
// Salvar
await cacheManager.saveString('my_key', 'my_value');

// Recuperar
String? value = cacheManager.getString('my_key');
```

### **Objetos (Serialização Automática)**

```dart
// Salvar objeto
await cacheManager.saveObject<TodoListModel>(
  'todo_key',
  myTodo,
  (todo) => todo.toMap(),
);

// Recuperar objeto
TodoListModel? todo = cacheManager.getObject<TodoListModel>(
  'todo_key',
  TodoListModel.fromMap,
);
```

### **Listas de Objetos**

```dart
// Salvar lista
await cacheManager.saveList<TodoListModel>(
  'todos_key',
  todosList,
  (todo) => todo.toMap(),
);

// Recuperar lista
List<TodoListModel> todos = cacheManager.getList<TodoListModel>(
  'todos_key',
  TodoListModel.fromMap,
);
```

### **Tipos Primitivos**

```dart
// Bool
await cacheManager.saveBool('is_logged', true);
bool? isLogged = cacheManager.getBool('is_logged');

// Int
await cacheManager.saveInt('user_id', 123);
int? userId = cacheManager.getInt('user_id');

// Double
await cacheManager.saveDouble('balance', 99.99);
double? balance = cacheManager.getDouble('balance');
```

### **Operações Gerais**

```dart
// Verificar se existe
bool exists = cacheManager.containsKey('my_key');

// Remover item
await cacheManager.remove('my_key');

// Limpar tudo
await cacheManager.clear();
```

---

## 💡 Exemplo Real: TodoListDataSource

### **ANTES (sem CacheManager)**

```dart
class TodoListLocalDataSourceImpl implements TodoListLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _todosKey = 'CACHED_TODOS';

  @override
  Future<List<TodoListModel>> getAllTodos() async {
    try {
      final jsonString = sharedPreferences.getString(_todosKey);

      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final List<dynamic> jsonList = json.decode(jsonString);
      final todos = jsonList
          .map((json) => TodoListModel.fromMap(json as Map<String, dynamic>))
          .toList();

      return todos;
    } catch (e) {
      throw CacheException(message: 'Erro ao buscar tarefas: ${e.toString()}');
    }
  }

  Future<void> _saveTodos(List<TodoListModel> todos) async {
    try {
      final jsonList = todos.map((todo) => todo.toMap()).toList();
      final jsonString = json.encode(jsonList);

      final success = await sharedPreferences.setString(_todosKey, jsonString);

      if (!success) {
        throw CacheException(message: 'Falha ao salvar tarefas');
      }
    } catch (e) {
      throw CacheException(message: 'Erro ao salvar: ${e.toString()}');
    }
  }
}
```

### **DEPOIS (com CacheManager)** ✨

```dart
class TodoListLocalDataSourceImpl implements TodoListLocalDataSource {
  final CacheManager cacheManager;
  static const String _todosKey = 'CACHED_TODOS';

  @override
  Future<List<TodoListModel>> getAllTodos() async {
    try {
      return cacheManager.getList<TodoListModel>(_todosKey, TodoListModel.fromMap);
    } catch (e) {
      throw CacheException(message: 'Erro ao buscar tarefas: ${e.toString()}');
    }
  }

  Future<void> _saveTodos(List<TodoListModel> todos) async {
    try {
      await cacheManager.saveList<TodoListModel>(
        _todosKey,
        todos,
        (todo) => todo.toMap(),
      );
    } catch (e) {
      throw CacheException(message: 'Erro ao salvar: ${e.toString()}');
    }
  }
}
```

**Redução: ~30 linhas → ~10 linhas** 🎉

---

## 🛡️ Tratamento de Erros

Todos os métodos lançam `CacheException` em caso de erro:

```dart
try {
  await cacheManager.saveString('key', 'value');
} on CacheException catch (e) {
  print('Erro de cache: ${e.message}');
}
```

---

## 🏗️ Arquitetura

```
┌─────────────────────────────────┐
│   DataSource Implementation     │
│  (TodoListLocalDataSourceImpl)  │
└────────────┬────────────────────┘
             │ usa
             ▼
┌─────────────────────────────────┐
│       CacheManager              │
│  (Wrapper customizado)          │
│  • Type-safe                    │
│  • Serialização automática      │
│  • Tratamento de erros          │
└────────────┬────────────────────┘
             │ encapsula
             ▼
┌─────────────────────────────────┐
│     SharedPreferences           │
│  (Package nativo Flutter)       │
└─────────────────────────────────┘
```

---

## ✅ Vantagens

1. **Código mais limpo**: Menos boilerplate nos DataSources
2. **Type-safe**: Genéricos garantem tipos corretos
3. **Reutilizável**: Use em qualquer DataSource que precise de cache
4. **Manutenível**: Lógica de cache centralizada
5. **Testável**: Fácil mockar o CacheManager
6. **Consistente**: Tratamento de erros padronizado

---

## 🧪 Testando

```dart
// Mock para testes
class MockCacheManager extends Mock implements CacheManager {}

void main() {
  test('deve salvar e recuperar lista de todos', () async {
    final mockCache = MockCacheManager();
    final dataSource = TodoListLocalDataSourceImpl(cacheManager: mockCache);

    when(() => mockCache.getList<TodoListModel>(any(), any()))
        .thenReturn([mockTodo]);

    final result = await dataSource.getAllTodos();

    expect(result.length, 1);
    verify(() => mockCache.getList<TodoListModel>(any(), any())).called(1);
  });
}
```

---

## 📊 Métodos Completos

| Método                           | Descrição           | Retorno        |
| -------------------------------- | ------------------- | -------------- |
| `saveString(key, value)`         | Salva string        | `Future<void>` |
| `getString(key)`                 | Recupera string     | `String?`      |
| `saveObject<T>(key, obj, toMap)` | Salva objeto        | `Future<void>` |
| `getObject<T>(key, fromMap)`     | Recupera objeto     | `T?`           |
| `saveList<T>(key, list, toMap)`  | Salva lista         | `Future<void>` |
| `getList<T>(key, fromMap)`       | Recupera lista      | `List<T>`      |
| `saveBool(key, value)`           | Salva bool          | `Future<void>` |
| `getBool(key)`                   | Recupera bool       | `bool?`        |
| `saveInt(key, value)`            | Salva int           | `Future<void>` |
| `getInt(key)`                    | Recupera int        | `int?`         |
| `saveDouble(key, value)`         | Salva double        | `Future<void>` |
| `getDouble(key)`                 | Recupera double     | `double?`      |
| `remove(key)`                    | Remove item         | `Future<void>` |
| `clear()`                        | Limpa tudo          | `Future<void>` |
| `containsKey(key)`               | Verifica existência | `bool`         |

---

## 🎯 Quando Usar

✅ **Use CacheManager quando:**

- Precisar armazenar dados localmente com SharedPreferences
- Quiser código limpo sem boilerplate de JSON
- Precisar de type-safety
- Quiser tratamento de erros consistente

❌ **NÃO use quando:**

- Precisar de banco de dados relacional (use SQLite/Hive)
- Dados muito grandes (SharedPreferences tem limites)
- Operações complexas de busca/filtro
- Dados sensíveis (use flutter_secure_storage)

---

**CacheManager: Simplicidade + Segurança! 🚀**
