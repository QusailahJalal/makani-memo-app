import '../entities/goal_entity.dart';
import '../../../../core/usecases/base_usecase.dart';

abstract class GoalRepository {
  Future<Result<List<GoalEntity>>> getGoals();
  Future<Result<List<GoalEntity>>> addGoal(String title, String? description);
  Future<Result<List<GoalEntity>>> toggleGoal(String id);
  Future<Result<List<GoalEntity>>> deleteGoal(String id);
}
