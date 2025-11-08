import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list_app/core/errors/exceptions.dart';
import 'package:todo_list_app/core/errors/failures.dart';
import 'package:todo_list_app/features/todoList/data/datasource/todo_list_local_datasource.dart';
import 'package:todo_list_app/features/todoList/data/models/todo_list_model.dart';
import 'package:todo_list_app/features/todoList/data/repository/todo_list_repository_impl.dart';
import 'package:todo_list_app/features/todoList/domain/entities/todo_list_entity.dart';

import 'todo_list_repository_impl_test.mocks.dart';

@GenerateMocks([TodoListLocalDataSource])
void main() {
  late TodoListRepositoryImpl repository;
  late MockTodoListLocalDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockTodoListLocalDataSource();
    repository = TodoListRepositoryImpl(localDataSource: mockDataSource);
  });

  final tTodoModel = TodoListModel(id: '1', title: 'Test Todo', description: 'Test Description', isCompleted: false);

  final tTodoEntity = TodoListEntity(id: '1', title: 'Test Todo', description: 'Test Description', isCompleted: false);

  final tTodoList = [
    TodoListModel(id: '1', title: 'Test Todo 1', description: 'Description 1', isCompleted: false),
    TodoListModel(id: '2', title: 'Test Todo 2', description: 'Description 2', isCompleted: true),
  ];

  group('getAllTodos', () {
    test('deve retornar lista de Entities quando DataSource retorna com sucesso', () async {
      when(mockDataSource.getAllTodos()).thenAnswer((_) async => tTodoList);

      final result = await repository.getAllTodos();

      expect(result.$1, isNull);
      expect(result.$2, isNotNull);
      expect(result.$2!.length, 2);
      expect(result.$2![0], isA<TodoListEntity>());
      expect(result.$2![0].id, '1');
      verify(mockDataSource.getAllTodos());
    });

    test('deve retornar CacheFailure quando DataSource lança CacheException', () async {
      when(mockDataSource.getAllTodos()).thenThrow(CacheException(message: 'Cache error'));

      final result = await repository.getAllTodos();

      expect(result.$1, isA<CacheFailure>());
      expect(result.$2, isNull);
      expect((result.$1 as CacheFailure).message, 'Cache error');
    });

    test('deve retornar UnknownFailure quando DataSource lança exceção genérica', () async {
      when(mockDataSource.getAllTodos()).thenThrow(Exception('Unknown error'));

      final result = await repository.getAllTodos();

      expect(result.$1, isA<UnknownFailure>());
      expect(result.$2, isNull);
    });
  });

  group('addTodo', () {
    test('deve retornar Entity quando DataSource adiciona com sucesso', () async {
      when(mockDataSource.addTodo(any)).thenAnswer((_) async => tTodoModel);

      final result = await repository.addTodo(tTodoEntity);

      expect(result.$1, isNull);
      expect(result.$2, isNotNull);
      expect(result.$2, isA<TodoListEntity>());
      expect(result.$2!.id, tTodoEntity.id);
      expect(result.$2!.title, tTodoEntity.title);
      verify(mockDataSource.addTodo(any));
    });

    test('deve retornar CacheFailure quando DataSource falha ao adicionar', () async {
      when(mockDataSource.addTodo(any)).thenThrow(CacheException(message: 'Failed to add'));

      final result = await repository.addTodo(tTodoEntity);

      expect(result.$1, isA<CacheFailure>());
      expect(result.$2, isNull);
    });
  });

  group('removeTodo', () {
    test('deve retornar true quando DataSource remove com sucesso', () async {
      when(mockDataSource.removeTodo(any)).thenAnswer((_) async => true);

      final result = await repository.removeTodo('1');

      expect(result.$1, isNull);
      expect(result.$2, true);
      verify(mockDataSource.removeTodo('1'));
    });

    test('deve retornar CacheFailure quando DataSource falha ao remover', () async {
      when(mockDataSource.removeTodo(any)).thenThrow(CacheException(message: 'Not found'));

      final result = await repository.removeTodo('1');

      expect(result.$1, isA<CacheFailure>());
      expect(result.$2, isNull);
    });
  });

  group('toggleTodoComplete', () {
    test('deve retornar Entity atualizada quando DataSource alterna com sucesso', () async {
      final completedModel = tTodoModel.copyWith(isCompleted: true);
      when(mockDataSource.toggleTodoComplete(any)).thenAnswer((_) async => completedModel);

      final result = await repository.toggleTodoComplete('1');

      expect(result.$1, isNull);
      expect(result.$2, isNotNull);
      expect(result.$2, isA<TodoListEntity>());
      expect(result.$2!.isCompleted, true);
      verify(mockDataSource.toggleTodoComplete('1'));
    });

    test('deve retornar CacheFailure quando DataSource falha ao alternar', () async {
      when(mockDataSource.toggleTodoComplete(any)).thenThrow(CacheException(message: 'Not found'));

      final result = await repository.toggleTodoComplete('1');

      expect(result.$1, isA<CacheFailure>());
      expect(result.$2, isNull);
    });
  });
}
