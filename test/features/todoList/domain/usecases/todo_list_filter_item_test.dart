import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list_app/core/errors/failures.dart';
import 'package:todo_list_app/features/todoList/domain/entities/todo_list_entity.dart';
import 'package:todo_list_app/features/todoList/domain/enums/todo_filter_enum.dart';
import 'package:todo_list_app/features/todoList/domain/repository/todo_list_repository.dart';
import 'package:todo_list_app/features/todoList/domain/usecases/todo_list_filter_item.dart';

import 'todo_list_filter_item_test.mocks.dart';

@GenerateMocks([TodoListRepository])
void main() {
  late TodoListFilterItem useCase;
  late MockTodoListRepository mockRepository;

  setUp(() {
    mockRepository = MockTodoListRepository();
    useCase = TodoListFilterItem(repository: mockRepository);
  });

  final tTodoList = [
    TodoListEntity(id: '1', title: 'Tarefa Pendente 1', description: 'Description 1', isCompleted: false),
    TodoListEntity(id: '2', title: 'Tarefa Concluída', description: 'Description 2', isCompleted: true),
    TodoListEntity(id: '3', title: 'Tarefa Pendente 2', description: 'Description 3', isCompleted: false),
  ];

  group('TodoListFilterItem', () {
    test('deve retornar todas as tarefas quando filtro é ALL', () async {
      when(mockRepository.getAllTodos()).thenAnswer((_) async => (null, tTodoList));

      final result = await useCase(TodoFilterEnum.all);

      expect(result.$1, null);
      expect(result.$2, tTodoList);
      expect(result.$2?.length, 3);
      verify(mockRepository.getAllTodos());
    });

    test('deve retornar apenas tarefas pendentes quando filtro é PENDING', () async {
      when(mockRepository.getAllTodos()).thenAnswer((_) async => (null, tTodoList));

      final result = await useCase(TodoFilterEnum.pending);

      expect(result.$1, null);
      expect(result.$2?.length, 2);
      expect(result.$2?.every((todo) => !todo.isCompleted), true);
      verify(mockRepository.getAllTodos());
    });

    test('deve retornar apenas tarefas concluídas quando filtro é DONE', () async {
      when(mockRepository.getAllTodos()).thenAnswer((_) async => (null, tTodoList));

      final result = await useCase(TodoFilterEnum.done);

      expect(result.$1, null);
      expect(result.$2?.length, 1);
      expect(result.$2?.every((todo) => todo.isCompleted), true);
      verify(mockRepository.getAllTodos());
    });

    test('deve retornar lista vazia quando não há tarefas', () async {
      when(mockRepository.getAllTodos()).thenAnswer((_) async => (null, <TodoListEntity>[]));

      final result = await useCase(TodoFilterEnum.all);

      expect(result.$1, null);
      expect(result.$2, isEmpty);
      verify(mockRepository.getAllTodos());
    });

    test('deve retornar CacheFailure quando repository falha', () async {
      when(mockRepository.getAllTodos()).thenAnswer((_) async => (const CacheFailure(message: 'Cache error'), null));

      final result = await useCase(TodoFilterEnum.all);

      expect(result.$1, isA<CacheFailure>());
      expect(result.$2, null);
      verify(mockRepository.getAllTodos());
    });
  });
}
