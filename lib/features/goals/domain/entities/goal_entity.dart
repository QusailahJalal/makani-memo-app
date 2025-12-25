import 'package:equatable/equatable.dart';

class GoalEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? completedAt;

  const GoalEntity({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    required this.createdAt,
    this.completedAt,
  });

  factory GoalEntity.create({required String title, String? description}) {
    return GoalEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
  }

  GoalEntity copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return GoalEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  GoalEntity toggleCompletion() => copyWith(
    isCompleted: !isCompleted,
    completedAt: !isCompleted ? DateTime.now() : null,
  );

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    isCompleted,
    createdAt,
    completedAt,
  ];
}
