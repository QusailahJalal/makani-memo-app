import 'package:equatable/equatable.dart';
import '../../domain/entities/goal_entity.dart';

abstract class GoalState extends Equatable {
  const GoalState();
  @override
  List<Object?> get props => [];
}

class GoalInitial extends GoalState {}

class GoalLoading extends GoalState {}

class GoalLoaded extends GoalState {
  final List<GoalEntity> goals;
  const GoalLoaded(this.goals);
  @override
  List<Object?> get props => [goals];

  int get completedCount => goals.where((g) => g.isCompleted).length;
  double get progress => goals.isEmpty ? 0 : completedCount / goals.length;
}

class GoalError extends GoalState {
  final String message;
  const GoalError(this.message);
  @override
  List<Object?> get props => [message];
}
