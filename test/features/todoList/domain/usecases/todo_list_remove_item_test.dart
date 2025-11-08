import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list_app/core/errors/failures.dart';
import 'package:todo_list_app/features/todoList/domain/repository/todo_list_repository.dart';
import 'package:todo_list_app/features/todoList/domain/usecases/todo_list_remove_item.dart';

import 'todo_list_remove_item_test.mocks.dart';

@GenerateMocks([TodoListRepository])
void main() {
  late TodoListRemoveItem useCase;
  late MockTodoListRepository mockRepository;

  setUp(() {
    mockRepository = MockTodoListRepository();
    useCase = TodoListRemoveItem(repository: mockRepository);
  });

  const tTodoId = '1';

  group('TodoListRemoveItem', () {
    test('deve remover tarefa com sucesso', () async {
      when(mockRepository.removeTodo(any)).thenAnswer((_) async => (null, true));

      final result = await useCase(tTodoId);

      expect(result.$1, null);
      expect(result.$2, true);
      verify(mockRepository.removeTodo(tTodoId));
      verifyNoMoreInteractions(mockRepository);
    });

    test('deve retornar ValidationFailure quando ID está vazio', () async {
      final result = await useCase('');

      expect(result.$1, isA<ValidationFailure>());
      expect(result.$2, null);
      verifyNever(mockRepository.removeTodo(any));
    });

    test('deve retornar ValidationFailure quando ID contém apenas espaços', () async {
      final result = await useCase('   ');

      expect(result.$1, isA<ValidationFailure>());
      expect(result.$2, null);
      verifyNever(mockRepository.removeTodo(any));
    });

    test('deve retornar NotFoundFailure quando tarefa não existe', () async {
      when(
        mockRepository.removeTodo(any),
      ).thenAnswer((_) async => (const NotFoundFailure(message: 'Tarefa não encontrada'), null));

      final result = await useCase(tTodoId);

      expect(result.$1, isA<NotFoundFailure>());
      expect(result.$2, null);
      verify(mockRepository.removeTodo(tTodoId));
    });
  });
}
