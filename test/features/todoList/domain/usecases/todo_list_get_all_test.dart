import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list_app/core/errors/failures.dart';
import 'package:todo_list_app/features/todoList/domain/entities/todo_list_entity.dart';
import 'package:todo_list_app/features/todoList/domain/repository/todo_list_repository.dart';
import 'package:todo_list_app/features/todoList/domain/usecases/todo_list_get_all.dart';

import 'todo_list_get_all_test.mocks.dart';

@GenerateMocks([TodoListRepository])
void main() {
  late TodoListGetAll useCase;
  late MockTodoListRepository mockRepository;

  setUp(() {
    mockRepository = MockTodoListRepository();
    useCase = TodoListGetAll(repository: mockRepository);
  });

  final tTodoList = [
    TodoListEntity(id: '1', title: 'Test Todo 1', description: 'Description 1', isCompleted: false),
    TodoListEntity(id: '2', title: 'Test Todo 2', description: 'Description 2', isCompleted: true),
  ];

  group('TodoListGetAll', () {
    test('deve retornar lista de tarefas quando repository retorna sucesso', () async {
      when(mockRepository.getAllTodos()).thenAnswer((_) async => (null, tTodoList));

      final result = await useCase();

      expect(result.$1, null);
      expect(result.$2, tTodoList);
      expect(result.$2?.length, 2);
      verify(mockRepository.getAllTodos());
      verifyNoMoreInteractions(mockRepository);
    });

    test('deve retornar lista vazia quando não há tarefas', () async {
      when(mockRepository.getAllTodos()).thenAnswer((_) async => (null, <TodoListEntity>[]));

      final result = await useCase();

      expect(result.$1, null);
      expect(result.$2, isEmpty);
      verify(mockRepository.getAllTodos());
    });

    test('deve retornar CacheFailure quando repository falha', () async {
      when(mockRepository.getAllTodos()).thenAnswer((_) async => (const CacheFailure(message: 'Cache error'), null));

      final result = await useCase();

      expect(result.$1, isA<CacheFailure>());
      expect(result.$2, null);
      verify(mockRepository.getAllTodos());
    });
  });
}
