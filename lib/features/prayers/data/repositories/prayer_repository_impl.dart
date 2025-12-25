import '../../../../core/usecases/base_usecase.dart';
import '../../domain/entities/prayer_entity.dart';
import '../../domain/repositories/prayer_repository.dart';
import '../datasources/prayer_local_datasource.dart';
import '../models/prayer_model.dart';

/// تنفيذ مستودع الصلوات
class PrayerRepositoryImpl implements PrayerRepository {
  final PrayerLocalDataSource localDataSource;

  PrayerRepositoryImpl(this.localDataSource);

  String get _todayDate => DateTime.now().toIso8601String().split('T')[0];

  @override
  Future<Result<PrayerTrackingEntity>> getTodayPrayers() async {
    try {
      final prayers = await localDataSource.getTodayPrayers(_todayDate);
      if (prayers != null) {
        return Result.success(prayers);
      }
      return Result.success(PrayerTrackingModel.empty(_todayDate));
    } catch (e) {
      return Result.failure(const CacheFailure());
    }
  }

  @override
  Future<Result<PrayerTrackingEntity>> togglePrayer(
    String prayerName,
    bool isExtra,
  ) async {
    try {
      // الحصول على الصلوات الحالية
      var prayers = await localDataSource.getTodayPrayers(_todayDate);
      prayers ??= PrayerTrackingModel.empty(_todayDate);

      // تبديل الحالة
      PrayerTrackingModel updatedPrayers;
      if (isExtra) {
        final extraPrayers = Map<String, bool>.from(prayers.extraPrayers);
        extraPrayers[prayerName] = !(extraPrayers[prayerName] ?? false);
        updatedPrayers = PrayerTrackingModel(
          date: prayers.date,
          prayers: prayers.prayers,
          extraPrayers: extraPrayers,
        );
      } else {
        final regularPrayers = Map<String, bool>.from(prayers.prayers);
        regularPrayers[prayerName] = !(regularPrayers[prayerName] ?? false);
        updatedPrayers = PrayerTrackingModel(
          date: prayers.date,
          prayers: regularPrayers,
          extraPrayers: prayers.extraPrayers,
        );
      }

      // حفظ التغييرات
      await localDataSource.savePrayers(updatedPrayers);
      return Result.success(updatedPrayers);
    } catch (e) {
      return Result.failure(const CacheFailure());
    }
  }

  @override
  Future<Result<void>> savePrayers(PrayerTrackingEntity prayers) async {
    try {
      await localDataSource.savePrayers(
        PrayerTrackingModel.fromEntity(prayers),
      );
      return Result.success(null);
    } catch (e) {
      return Result.failure(const CacheFailure());
    }
  }
}
