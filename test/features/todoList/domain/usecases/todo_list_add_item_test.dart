import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list_app/core/errors/failures.dart';
import 'package:todo_list_app/features/todoList/domain/entities/todo_list_entity.dart';
import 'package:todo_list_app/features/todoList/domain/repository/todo_list_repository.dart';
import 'package:todo_list_app/features/todoList/domain/usecases/todo_list_add_item.dart';

import 'todo_list_add_item_test.mocks.dart';

@GenerateMocks([TodoListRepository])
void main() {
  late TodoListAddItem useCase;
  late MockTodoListRepository mockRepository;

  setUp(() {
    mockRepository = MockTodoListRepository();
    useCase = TodoListAddItem(repository: mockRepository);
  });

  final tTodo = TodoListEntity(id: '1', title: 'Test Todo', description: 'Test Description', isCompleted: false);

  group('TodoListAddItem', () {
    test('deve adicionar tarefa com sucesso quando dados são válidos', () async {
      when(mockRepository.addTodo(any)).thenAnswer((_) async => (null, tTodo));

      final result = await useCase(tTodo);

      expect(result.$1, null);
      expect(result.$2, tTodo);
      verify(mockRepository.addTodo(tTodo));
      verifyNoMoreInteractions(mockRepository);
    });

    test('deve retornar ValidationFailure quando título está vazio', () async {
      final invalidTodo = TodoListEntity(id: '1', title: '', description: 'Test', isCompleted: false);

      final result = await useCase(invalidTodo);

      expect(result.$1, isA<ValidationFailure>());
      expect(result.$2, null);
      verifyNever(mockRepository.addTodo(any));
    });

    test('deve retornar ValidationFailure quando título tem menos de 3 caracteres', () async {
      final invalidTodo = TodoListEntity(id: '1', title: 'AB', description: 'Test', isCompleted: false);

      final result = await useCase(invalidTodo);

      expect(result.$1, isA<ValidationFailure>());
      expect(result.$2, null);
      verifyNever(mockRepository.addTodo(any));
    });

    test('deve retornar CacheFailure quando repository falha', () async {
      when(mockRepository.addTodo(any)).thenAnswer((_) async => (const CacheFailure(message: 'Cache error'), null));

      final result = await useCase(tTodo);

      expect(result.$1, isA<CacheFailure>());
      expect(result.$2, null);
      verify(mockRepository.addTodo(tTodo));
    });
  });
}
