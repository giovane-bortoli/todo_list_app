import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list_app/core/errors/failures.dart';
import 'package:todo_list_app/features/todoList/domain/entities/todo_list_entity.dart';
import 'package:todo_list_app/features/todoList/domain/repository/todo_list_repository.dart';
import 'package:todo_list_app/features/todoList/domain/usecases/todo_list_toggle_complete.dart';

import 'todo_list_toggle_complete_test.mocks.dart';

@GenerateMocks([TodoListRepository])
void main() {
  late TodoListToggleComplete useCase;
  late MockTodoListRepository mockRepository;

  setUp(() {
    mockRepository = MockTodoListRepository();
    useCase = TodoListToggleComplete(repository: mockRepository);
  });

  const tTodoId = '1';
  final tTodo = TodoListEntity(id: tTodoId, title: 'Test Todo', description: 'Description', isCompleted: false);
  final tToggledTodo = TodoListEntity(id: tTodoId, title: 'Test Todo', description: 'Description', isCompleted: true);

  group('TodoListToggleComplete', () {
    test('deve alternar status de tarefa com sucesso', () async {
      when(mockRepository.toggleTodoComplete(any)).thenAnswer((_) async => (null, tToggledTodo));

      final result = await useCase(tTodoId);

      expect(result.$1, null);
      expect(result.$2, tToggledTodo);
      expect(result.$2?.isCompleted, true);
      verify(mockRepository.toggleTodoComplete(tTodoId));
      verifyNoMoreInteractions(mockRepository);
    });

    test('deve retornar ValidationFailure quando ID está vazio', () async {
      final result = await useCase('');

      expect(result.$1, isA<ValidationFailure>());
      expect(result.$2, null);
      verifyNever(mockRepository.toggleTodoComplete(any));
    });

    test('deve retornar ValidationFailure quando ID contém apenas espaços', () async {
      final result = await useCase('   ');

      expect(result.$1, isA<ValidationFailure>());
      expect(result.$2, null);
      verifyNever(mockRepository.toggleTodoComplete(any));
    });

    test('deve retornar NotFoundFailure quando tarefa não existe', () async {
      when(
        mockRepository.toggleTodoComplete(any),
      ).thenAnswer((_) async => (const NotFoundFailure(message: 'Tarefa não encontrada'), null));

      final result = await useCase(tTodoId);

      expect(result.$1, isA<NotFoundFailure>());
      expect(result.$2, null);
      verify(mockRepository.toggleTodoComplete(tTodoId));
    });
  });
}
