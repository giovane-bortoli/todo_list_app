import 'dart:convert';

import 'package:todo_list_app/features/todoList/domain/entities/todo_list_entity.dart';

class TodoListModel extends TodoListEntity {
  TodoListModel({required super.id, required super.title, required super.description, super.isCompleted});

  TodoListModel copyWith({String? id, String? title, String? description, bool? isCompleted}) {
    return TodoListModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'title': title, 'description': description, 'isCompleted': isCompleted};
  }

  factory TodoListModel.fromMap(Map<String, dynamic> map) {
    return TodoListModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      isCompleted: map['isCompleted'] as bool? ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoListModel.fromJson(String source) {
    return TodoListModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  factory TodoListModel.fromEntity(TodoListEntity entity) {
    return TodoListModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isCompleted: entity.isCompleted,
    );
  }

  TodoListEntity toEntity() {
    return TodoListEntity(id: id, title: title, description: description, isCompleted: isCompleted);
  }

  @override
  String toString() {
    return 'TodoListModel(id: $id, title: $title, description: $description, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(covariant TodoListModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ description.hashCode ^ isCompleted.hashCode;
  }
}
