import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list_app/core/errors/exceptions.dart';
import 'package:todo_list_app/core/utils/cache_manager.dart';
import 'package:todo_list_app/features/todoList/data/datasource/todo_list_local_datasource_impl.dart';
import 'package:todo_list_app/features/todoList/data/models/todo_list_model.dart';

import 'todo_list_local_datasource_impl_test.mocks.dart';

@GenerateMocks([CacheManager])
void main() {
  late TodoListLocalDataSourceImpl dataSource;
  late MockCacheManager mockCacheManager;

  setUp(() {
    mockCacheManager = MockCacheManager();
    dataSource = TodoListLocalDataSourceImpl(cacheManager: mockCacheManager);
  });

  final tTodoModel = TodoListModel(id: '1', title: 'Test Todo', description: 'Test Description', isCompleted: false);

  final tTodoList = [
    TodoListModel(id: '1', title: 'Test Todo 1', description: 'Description 1', isCompleted: false),
    TodoListModel(id: '2', title: 'Test Todo 2', description: 'Description 2', isCompleted: true),
  ];

  group('getAllTodos', () {
    test('deve retornar lista de TodoListModel do CacheManager', () async {
      when(mockCacheManager.getList<TodoListModel>(any, any)).thenReturn(tTodoList);

      final result = await dataSource.getAllTodos();

      expect(result, tTodoList);
      expect(result.length, 2);
      verify(mockCacheManager.getList<TodoListModel>('CACHED_TODOS', any));
    });

    test('deve retornar lista vazia quando não há tarefas no cache', () async {
      when(mockCacheManager.getList<TodoListModel>(any, any)).thenReturn(<TodoListModel>[]);

      final result = await dataSource.getAllTodos();

      expect(result, isEmpty);
      verify(mockCacheManager.getList<TodoListModel>('CACHED_TODOS', any));
    });

    test('deve lançar CacheException quando CacheManager falha', () async {
      when(mockCacheManager.getList<TodoListModel>(any, any)).thenThrow(Exception('Cache error'));

      expect(() => dataSource.getAllTodos(), throwsA(isA<CacheException>()));
    });
  });

  group('addTodo', () {
    test('deve adicionar tarefa e salvar no cache', () async {
      when(mockCacheManager.getList<TodoListModel>(any, any)).thenReturn([]);
      when(mockCacheManager.saveList<TodoListModel>(any, any, any)).thenAnswer((_) async => {});

      final result = await dataSource.addTodo(tTodoModel);

      expect(result, tTodoModel);
      verify(mockCacheManager.getList<TodoListModel>('CACHED_TODOS', any));
      verify(mockCacheManager.saveList<TodoListModel>('CACHED_TODOS', any, any));
    });

    test('deve adicionar tarefa à lista existente', () async {
      when(mockCacheManager.getList<TodoListModel>(any, any)).thenReturn([tTodoList[0]]);
      when(mockCacheManager.saveList<TodoListModel>(any, any, any)).thenAnswer((_) async => {});

      await dataSource.addTodo(tTodoList[1]);

      verify(
        mockCacheManager.saveList<TodoListModel>(
          'CACHED_TODOS',
          argThat(predicate<List<TodoListModel>>((list) => list.length == 2)),
          any,
        ),
      );
    });

    test('deve lançar CacheException quando falha ao adicionar', () async {
      when(mockCacheManager.getList<TodoListModel>(any, any)).thenThrow(Exception('Cache error'));

      expect(() => dataSource.addTodo(tTodoModel), throwsA(isA<CacheException>()));
    });
  });

  group('removeTodo', () {
    test('deve remover tarefa com sucesso', () async {
      when(mockCacheManager.getList<TodoListModel>(any, any)).thenReturn(tTodoList);
      when(mockCacheManager.saveList<TodoListModel>(any, any, any)).thenAnswer((_) async => {});

      final result = await dataSource.removeTodo('1');

      expect(result, true);
      verify(
        mockCacheManager.saveList<TodoListModel>(
          'CACHED_TODOS',
          argThat(predicate<List<TodoListModel>>((list) => list.length == 1)),
          any,
        ),
      );
    });

    test('deve lançar CacheException quando tarefa não existe', () async {
      when(mockCacheManager.getList<TodoListModel>(any, any)).thenReturn(tTodoList);

      expect(() => dataSource.removeTodo('999'), throwsA(isA<CacheException>()));
    });
  });

  group('toggleTodoComplete', () {
    test('deve alternar status de tarefa com sucesso', () async {
      when(mockCacheManager.getList<TodoListModel>(any, any)).thenReturn([tTodoModel]);
      when(mockCacheManager.saveList<TodoListModel>(any, any, any)).thenAnswer((_) async => {});

      final result = await dataSource.toggleTodoComplete('1');

      expect(result.isCompleted, true);
      verify(mockCacheManager.saveList<TodoListModel>('CACHED_TODOS', any, any));
    });

    test('deve lançar CacheException quando tarefa não existe', () async {
      when(mockCacheManager.getList<TodoListModel>(any, any)).thenReturn(tTodoList);

      expect(() => dataSource.toggleTodoComplete('999'), throwsA(isA<CacheException>()));
    });
  });

  group('getTodoById', () {
    test('deve retornar tarefa quando encontrada', () async {
      final mockList = [
        TodoListModel(id: '1', title: 'Test Todo 1', description: 'Description 1', isCompleted: false),
        TodoListModel(id: '2', title: 'Test Todo 2', description: 'Description 2', isCompleted: true),
      ];

      when(mockCacheManager.getList<TodoListModel>(any, any)).thenReturn(mockList);

      final result = await dataSource.getTodoById('1');

      expect(result, isNotNull);
      expect(result?.id, '1');
      verify(mockCacheManager.getList<TodoListModel>(any, any));
    });

    test('deve retornar null quando tarefa não encontrada', () async {
      when(mockCacheManager.getList<TodoListModel>(any, any)).thenReturn(tTodoList);

      final result = await dataSource.getTodoById('999');

      expect(result, isNull);
      verify(mockCacheManager.getList<TodoListModel>(any, any));
    });

    test('deve lançar CacheException quando cache falha', () async {
      when(mockCacheManager.getList<TodoListModel>(any, any)).thenThrow(Exception('Cache error'));

      expect(() => dataSource.getTodoById('1'), throwsA(isA<CacheException>()));
    });
  });
}
