class TodoListEntity {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  TodoListEntity({required this.id, required this.title, required this.description, this.isCompleted = false});
}
