class TodoEntity {
  const TodoEntity({
    required this.id,
    required this.description,
    required this.completedAt,
  });

  final String id;
  final String description;
  final DateTime? completedAt;

  bool get done {
    return completedAt != null;
  }

  TodoEntity copyWith({
    String? id,
    String? description,
    DateTime? completedAt,
  }) => TodoEntity(
    id: id ?? this.id,
    description: description ?? this.description,
    completedAt: completedAt ?? this.completedAt,
  );
}
