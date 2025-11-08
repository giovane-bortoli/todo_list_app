import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list_app/features/todoList/domain/enums/todo_filter_enum.dart';

class SegmentedCustomButtonWidget extends StatelessWidget {
  final TodoFilterEnum selectedFilter;
  final Function(TodoFilterEnum) onFilterChanged;

  const SegmentedCustomButtonWidget({super.key, required this.selectedFilter, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 30.w))),
      showSelectedIcon: false,
      segments: const <ButtonSegment<TodoFilterEnum>>[
        ButtonSegment<TodoFilterEnum>(value: TodoFilterEnum.all, label: Text('All')),
        ButtonSegment<TodoFilterEnum>(value: TodoFilterEnum.pending, label: Text('Pending')),
        ButtonSegment<TodoFilterEnum>(value: TodoFilterEnum.done, label: Text('Done')),
      ],
      selected: {selectedFilter},
      onSelectionChanged: (Set<TodoFilterEnum> newSelection) {
        onFilterChanged(newSelection.first);
      },
    );
  }
}
