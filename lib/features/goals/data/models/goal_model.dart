import '../../domain/entities/goal_entity.dart';

class GoalModel extends GoalEntity {
  const GoalModel({
    required super.id,
    required super.title,
    super.description,
    super.isCompleted,
    required super.createdAt,
    super.completedAt,
  });

  factory GoalModel.fromJson(Map<String, dynamic> json) => GoalModel(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String?,
    isCompleted: json['isCompleted'] as bool? ?? false,
    createdAt: DateTime.parse(json['createdAt'] as String),
    completedAt: json['completedAt'] != null
        ? DateTime.parse(json['completedAt'] as String)
        : null,
  );

  factory GoalModel.fromEntity(GoalEntity e) => GoalModel(
    id: e.id,
    title: e.title,
    description: e.description,
    isCompleted: e.isCompleted,
    createdAt: e.createdAt,
    completedAt: e.completedAt,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'isCompleted': isCompleted,
    'createdAt': createdAt.toIso8601String(),
    'completedAt': completedAt?.toIso8601String(),
  };
}
