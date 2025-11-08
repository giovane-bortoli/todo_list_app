# TodoList Feature - Clean Architecture

Aplicação de lista de tarefas implementada seguindo os princípios de Clean Architecture com gerenciamento de estado via Command Pattern.

## 📂 Estrutura

```
features/todoList/
├── data/
│   ├── datasource/
│   │   ├── todo_list_local_datasource.dart
│   │   └── todo_list_local_datasource_impl.dart
│   ├── models/
│   │   └── todo_list_model.dart
│   └── repository/
│       └── todo_list_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── todo_list_entity.dart
│   ├── enums/
│   │   └── todo_filter_enum.dart
│   ├── repository/
│   │   └── todo_list_repository.dart
│   └── usecases/
│       ├── todo_list_add_item.dart
│       ├── todo_list_filter_item.dart
│       ├── todo_list_get_all.dart
│       ├── todo_list_remove_item.dart
│       └── todo_list_toggle_complete.dart
├── presentation/
│   ├── controller/
│   │   └── todo_list_controller.dart
│   ├── screens/
│   │   └── todo_list_screen.dart
│   └── widgets/
│       ├── add_todo_dialog.dart
│       ├── segmented_custom_button_widget.dart
│       └── todo_list_view_widget.dart
├── todo_dependencies.dart
└── todo_routes.dart
```

## 🏗️ Arquitetura

### Domain Layer
- **Entity**: `TodoListEntity` - modelo de negócio puro
- **Repository Interface**: contrato abstrato para operações
- **UseCases**: operações de negócio isoladas (GetAll, Add, Remove, Toggle, Filter)

### Data Layer
- **Model**: `TodoListModel` - extensão da Entity com serialização
- **DataSource**: implementação com CacheManager (SharedPreferences)
- **Repository Implementation**: conversão Entity ↔ Model

### Presentation Layer
- **Controller**: gerenciamento de estado com Command Pattern
- **Screens**: TodoListScreen com ListenableBuilder
- **Widgets**: componentes reutilizáveis (dialog, filtro, lista)

## 🎯 Funcionalidades

- ✅ Adicionar tarefas com validação
- ✅ Marcar/desmarcar como completa
- ✅ Remover tarefas
- ✅ Filtrar por: Todas, Pendentes, Concluídas
- ✅ Persistência local com SharedPreferences
- ✅ Interface responsiva com Material 3

## 💾 Persistência

Utiliza `CacheManager` customizado que encapsula operações do SharedPreferences:
- Serialização/desserialização automática
- Tratamento de erros
- API tipo-segura

## 🔄 Gerenciamento de Estado

**Command Pattern** com `ChangeNotifier`:
- `todosCommand`: lista de tarefas
- `filterCommand`: filtro ativo
- `isLoadingCommand`: estado de loading
- `errorCommand`: mensagens de erro

**ListenableBuilder** para rebuild otimizado da UI

## 🧪 Validações

- Título obrigatório (mínimo 3 caracteres)
- ID obrigatório para operações específicas
- Tratamento de erros com Failures

## 📦 Dependency Injection

GetIt com registro modular:
- Singleton: SharedPreferences, CacheManager, DataSource, Repository, UseCases
- Factory: TodoListController (nova instância por tela)

## 🎨 UI/UX

- Material Design 3
- SegmentedButton para filtros
- Dialog para adicionar tarefas
- Loading states e empty states
- Feedback visual com SnackBar

---

**Clean Architecture + Command Pattern = Código limpo, testável e escalável** 🎉
