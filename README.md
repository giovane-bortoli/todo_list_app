# TodoList App

Aplicação de gerenciamento de tarefas construída com Flutter, implementando Clean Architecture e Command Pattern para gerenciamento de estado.

## 🎯 Sobre o Projeto

Aplicação completa de lista de tarefas (TodoList) que demonstra boas práticas de arquitetura de software, separação de responsabilidades e código limpo e testável.

## ✨ Funcionalidades

- ✅ Criar, visualizar e remover tarefas
- ✅ Marcar tarefas como concluídas/pendentes
- ✅ Filtrar tarefas por status (Todas, Pendentes, Concluídas)
- ✅ Persistência local de dados
- ✅ Interface moderna com Material Design 3
- ✅ Gerenciamento de estado reativo

## 🏗️ Arquitetura

**Clean Architecture** com três camadas principais:

### Domain Layer (Núcleo de Negócio)

- Entities: modelos de negócio puros
- UseCases: operações de negócio isoladas
- Repository Interfaces: contratos abstratos

### Data Layer (Implementação)

- Models: extensões das entities com serialização
- DataSources: fonte de dados (local com SharedPreferences)
- Repository Implementation: conversão entre camadas

### Presentation Layer (Interface)

- Controllers: gerenciamento de estado com Command Pattern
- Screens: telas da aplicação
- Widgets: componentes reutilizáveis

## 🔧 Tecnologias

- **Flutter** ^3.9.2
- **SharedPreferences** - persistência local
- **GetIt** - dependency injection
- **ScreenUtil** - responsividade
- **Command Pattern** - gerenciamento de estado

## 📦 Estrutura do Projeto

```
lib/
├── core/
│   ├── di/              # Dependency Injection
│   ├── errors/          # Exceptions e Failures
│   ├── routes/          # Rotas da aplicação
│   ├── utils/           # Utilitários (Command, CacheManager)
│   └── widgets/         # Widgets compartilhados
├── features/
│   └── todoList/        # Feature TodoList
│       ├── data/        # Models, DataSources, Repositories
│       ├── domain/      # Entities, UseCases, Interfaces
│       └── presentation/# Controllers, Screens, Widgets
└── shared/
    └── theme/           # Tema da aplicação
```

## 🎨 Design Patterns Utilizados

- **Clean Architecture**: separação em camadas
- **Repository Pattern**: abstração de fonte de dados
- **Use Case Pattern**: operações de negócio isoladas
- **Command Pattern**: gerenciamento de estado reativo
- **Dependency Injection**: inversão de controle com GetIt
- **Factory Pattern**: criação de instâncias

## 🧪 Princípios SOLID

- **S**ingle Responsibility: cada classe tem uma única responsabilidade
- **O**pen/Closed: aberto para extensão, fechado para modificação
- **L**iskov Substitution: substituição de implementações
- **I**nterface Segregation: interfaces específicas
- **D**ependency Inversion: dependências de abstrações

## 📱 Screenshots

[Em desenvolvimento]

## 🔜 Próximas Melhorias

- [ ] Adicionar testes unitários
- [ ] Implementar testes de widget
- [ ] Adicionar categorias/tags às tarefas
- [ ] Implementar busca de tarefas
- [ ] Adicionar datas de criação/conclusão
- [ ] Migrar para Hive ou SQLite
- [ ] Sincronização com backend
