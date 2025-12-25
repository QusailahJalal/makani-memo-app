import '../../../../core/usecases/base_usecase.dart';
import '../entities/quran_entity.dart';
import '../repositories/quran_repository.dart';

class GetQuranProgressUseCase
    implements UseCase<Result<QuranProgressEntity>, NoParams> {
  final QuranRepository repository;
  GetQuranProgressUseCase(this.repository);

  @override
  Future<Result<QuranProgressEntity>> call(NoParams params) =>
      repository.getQuranProgress();
}

class ToggleJuzParams {
  final int juzIndex;
  ToggleJuzParams(this.juzIndex);
}

class ToggleJuzUseCase
    implements UseCase<Result<QuranProgressEntity>, ToggleJuzParams> {
  final QuranRepository repository;
  ToggleJuzUseCase(this.repository);

  @override
  Future<Result<QuranProgressEntity>> call(ToggleJuzParams params) =>
      repository.toggleJuz(params.juzIndex);
}

class UpdatePagesReadUseCase
    implements UseCase<Result<QuranProgressEntity>, int> {
  final QuranRepository repository;
  UpdatePagesReadUseCase(this.repository);

  @override
  Future<Result<QuranProgressEntity>> call(int pages) =>
      repository.updatePagesRead(pages);
}

class UpdateDailyGoalUseCase
    implements UseCase<Result<QuranProgressEntity>, int> {
  final QuranRepository repository;
  UpdateDailyGoalUseCase(this.repository);

  @override
  Future<Result<QuranProgressEntity>> call(int pages) =>
      repository.updateDailyGoal(pages);
}
