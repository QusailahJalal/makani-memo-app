import '../../../../core/usecases/base_usecase.dart';
import '../../domain/entities/goal_entity.dart';
import '../../domain/repositories/goal_repository.dart';
import '../datasources/goal_local_datasource.dart';
import '../models/goal_model.dart';

class GoalRepositoryImpl implements GoalRepository {
  final GoalLocalDataSource localDataSource;
  GoalRepositoryImpl(this.localDataSource);

  @override
  Future<Result<List<GoalEntity>>> getGoals() async {
    try {
      final goals = await localDataSource.getGoals();
      return Result.success(goals);
    } catch (e) {
      return Result.failure(const CacheFailure());
    }
  }

  @override
  Future<Result<List<GoalEntity>>> addGoal(
    String title,
    String? description,
  ) async {
    try {
      final goals = await localDataSource.getGoals();
      final newGoal = GoalModel.fromEntity(
        GoalEntity.create(title: title, description: description),
      );
      goals.add(newGoal);
      await localDataSource.saveGoals(goals);
      return Result.success(goals);
    } catch (e) {
      return Result.failure(const CacheFailure());
    }
  }

  @override
  Future<Result<List<GoalEntity>>> toggleGoal(String id) async {
    try {
      final goals = await localDataSource.getGoals();
      final index = goals.indexWhere((g) => g.id == id);
      if (index != -1) {
        final toggled = goals[index].toggleCompletion();
        goals[index] = GoalModel.fromEntity(toggled);
        await localDataSource.saveGoals(goals);
      }
      return Result.success(goals);
    } catch (e) {
      return Result.failure(const CacheFailure());
    }
  }

  @override
  Future<Result<List<GoalEntity>>> deleteGoal(String id) async {
    try {
      final goals = await localDataSource.getGoals();
      goals.removeWhere((g) => g.id == id);
      await localDataSource.saveGoals(goals);
      return Result.success(goals);
    } catch (e) {
      return Result.failure(const CacheFailure());
    }
  }
}
