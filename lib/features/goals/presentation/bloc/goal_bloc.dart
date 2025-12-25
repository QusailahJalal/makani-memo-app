import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/goal_repository.dart';
import 'goal_event.dart';
import 'goal_state.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  final GoalRepository repository;

  GoalBloc({required this.repository}) : super(GoalInitial()) {
    on<LoadGoalsEvent>(_onLoad);
    on<AddGoalEvent>(_onAdd);
    on<ToggleGoalEvent>(_onToggle);
    on<DeleteGoalEvent>(_onDelete);
  }

  Future<void> _onLoad(LoadGoalsEvent event, Emitter<GoalState> emit) async {
    emit(GoalLoading());
    final result = await repository.getGoals();
    if (result.isSuccess)
      emit(GoalLoaded(result.data!));
    else
      emit(GoalError(result.failure!.message));
  }

  Future<void> _onAdd(AddGoalEvent event, Emitter<GoalState> emit) async {
    final result = await repository.addGoal(event.title, event.description);
    if (result.isSuccess) emit(GoalLoaded(result.data!));
  }

  Future<void> _onToggle(ToggleGoalEvent event, Emitter<GoalState> emit) async {
    final result = await repository.toggleGoal(event.id);
    if (result.isSuccess) emit(GoalLoaded(result.data!));
  }

  Future<void> _onDelete(DeleteGoalEvent event, Emitter<GoalState> emit) async {
    final result = await repository.deleteGoal(event.id);
    if (result.isSuccess) emit(GoalLoaded(result.data!));
  }
}
