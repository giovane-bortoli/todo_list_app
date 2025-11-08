import 'package:flutter/material.dart';
import 'package:todo_list_app/features/todoList/presentation/controller/todo_list_controller.dart';

class TodoListViewWidget extends StatelessWidget {
  final TodoListController controller;

  const TodoListViewWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ListView.builder(
      itemCount: controller.todosCommand.data.length,
      itemBuilder: (context, index) {
        final todo = controller.todosCommand.data[index];
        return ListTile(
          leading: Checkbox(value: todo.isCompleted, onChanged: (_) => controller.toggleTodoComplete(todo.id)),
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
              color: todo.isCompleted ? colors.onSurface.withValues(alpha: 0.6) : colors.onSurface,
            ),
          ),
          subtitle: todo.description.isNotEmpty
              ? Text(
                  todo.description,
                  style: TextStyle(
                    decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                    color: todo.isCompleted
                        ? colors.onSurface.withValues(alpha: 0.5)
                        : colors.onSurface.withValues(alpha: 0.7),
                  ),
                )
              : null,
          trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => controller.removeTodo(todo.id)),
        );
      },
    );
  }
}
