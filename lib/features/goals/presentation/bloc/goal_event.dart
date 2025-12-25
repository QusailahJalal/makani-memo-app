import 'package:equatable/equatable.dart';

abstract class GoalEvent extends Equatable {
  const GoalEvent();
  @override
  List<Object?> get props => [];
}

class LoadGoalsEvent extends GoalEvent {}

class AddGoalEvent extends GoalEvent {
  final String title;
  final String? description;
  const AddGoalEvent({required this.title, this.description});
  @override
  List<Object?> get props => [title, description];
}

class ToggleGoalEvent extends GoalEvent {
  final String id;
  const ToggleGoalEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class DeleteGoalEvent extends GoalEvent {
  final String id;
  const DeleteGoalEvent(this.id);
  @override
  List<Object?> get props => [id];
}
