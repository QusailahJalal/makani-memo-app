import '../../../../core/usecases/base_usecase.dart';
import '../../domain/entities/quran_entity.dart';
import '../../domain/repositories/quran_repository.dart';
import '../datasources/quran_local_datasource.dart';
import '../models/quran_model.dart';

class QuranRepositoryImpl implements QuranRepository {
  final QuranLocalDataSource localDataSource;
  QuranRepositoryImpl(this.localDataSource);

  String get _todayDate => DateTime.now().toIso8601String().split('T')[0];

  @override
  Future<Result<QuranProgressEntity>> getQuranProgress() async {
    try {
      var progress = await localDataSource.getQuranProgress();
      progress ??= QuranProgressModel.empty();

      // Reset daily pages if new day
      if (progress.lastReadDate != _todayDate) {
        progress = QuranProgressModel(
          completedJuz: progress.completedJuz,
          dailyGoalPages: progress.dailyGoalPages,
          pagesReadToday: 0,
          lastReadDate: _todayDate,
        );
        await localDataSource.saveQuranProgress(progress);
      }
      return Result.success(progress);
    } catch (e) {
      return Result.failure(const CacheFailure());
    }
  }

  @override
  Future<Result<QuranProgressEntity>> toggleJuz(int juzIndex) async {
    try {
      var progress =
          await localDataSource.getQuranProgress() ??
          QuranProgressModel.empty();
      final newCompletedJuz = List<bool>.from(progress.completedJuz);
      newCompletedJuz[juzIndex] = !newCompletedJuz[juzIndex];

      final updated = QuranProgressModel(
        completedJuz: newCompletedJuz,
        dailyGoalPages: progress.dailyGoalPages,
        pagesReadToday: progress.pagesReadToday,
        lastReadDate: progress.lastReadDate,
      );
      await localDataSource.saveQuranProgress(updated);
      return Result.success(updated);
    } catch (e) {
      return Result.failure(const CacheFailure());
    }
  }

  @override
  Future<Result<QuranProgressEntity>> updatePagesRead(int pages) async {
    try {
      var progress =
          await localDataSource.getQuranProgress() ??
          QuranProgressModel.empty();
      final updated = QuranProgressModel(
        completedJuz: progress.completedJuz,
        dailyGoalPages: progress.dailyGoalPages,
        pagesReadToday: pages,
        lastReadDate: _todayDate,
      );
      await localDataSource.saveQuranProgress(updated);
      return Result.success(updated);
    } catch (e) {
      return Result.failure(const CacheFailure());
    }
  }

  @override
  Future<Result<QuranProgressEntity>> updateDailyGoal(int pages) async {
    try {
      var progress =
          await localDataSource.getQuranProgress() ??
          QuranProgressModel.empty();
      final updated = QuranProgressModel(
        completedJuz: progress.completedJuz,
        dailyGoalPages: pages,
        pagesReadToday: progress.pagesReadToday,
        lastReadDate: progress.lastReadDate,
      );
      await localDataSource.saveQuranProgress(updated);
      return Result.success(updated);
    } catch (e) {
      return Result.failure(const CacheFailure());
    }
  }
}
