import '../entities/quran_entity.dart';
import '../../../../core/usecases/base_usecase.dart';

abstract class QuranRepository {
  Future<Result<QuranProgressEntity>> getQuranProgress();
  Future<Result<QuranProgressEntity>> toggleJuz(int juzIndex);
  Future<Result<QuranProgressEntity>> updatePagesRead(int pages);
  Future<Result<QuranProgressEntity>> updateDailyGoal(int pages);
}
