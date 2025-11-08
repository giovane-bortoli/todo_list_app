import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/core/di/service_locator.dart';
import 'package:todo_list_app/features/todoList/presentation/controller/todo_list_controller.dart';
import 'package:todo_list_app/features/todoList/presentation/widgets/add_todo_dialog.dart';
import 'package:todo_list_app/features/todoList/presentation/widgets/segmented_custom_button_widget.dart';
import 'package:todo_list_app/features/todoList/presentation/widgets/todo_list_view_widget.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late final TodoListController controller;

  @override
  void initState() {
    super.initState();
    controller = sl<TodoListController>();
    controller.loadTodos();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Todo List'), centerTitle: true, backgroundColor: colors.primary),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            ListenableBuilder(
              listenable: controller.filterCommand,
              builder: (context, _) => Center(
                child: SegmentedCustomButtonWidget(
                  selectedFilter: controller.filterCommand.data,
                  onFilterChanged: (filter) => controller.applyFilter(filter),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListenableBuilder(
                listenable: Listenable.merge([
                  controller.todosCommand,
                  controller.isLoadingCommand,
                  controller.errorCommand,
                ]),
                builder: (context, _) {
                  if (controller.errorCommand.data != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(controller.errorCommand.data!)));
                      controller.errorCommand.setData(null);
                    });
                  }

                  if (controller.isLoadingCommand.data) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.todosCommand.data.isEmpty) {
                    return Center(
                      child: Text(
                        'Nenhuma tarefa encontrada',
                        style: TextStyle(fontSize: 16.sp, color: colors.onSurface.withValues(alpha: 0.6)),
                      ),
                    );
                  }

                  return TodoListViewWidget(controller: controller);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _showAddTodoDialog, child: const Icon(Icons.add)),
    );
  }

  Future<void> _showAddTodoDialog() async {
    final todo = await showDialog(context: context, builder: (context) => const AddTodoDialog());
    if (todo != null) {
      await controller.addTodo(todo);
    }
  }
}
