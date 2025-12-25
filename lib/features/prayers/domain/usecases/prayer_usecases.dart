import '../../../../core/usecases/base_usecase.dart';
import '../entities/prayer_entity.dart';
import '../repositories/prayer_repository.dart';

/// حالة استخدام: الحصول على صلوات اليوم
class GetTodayPrayersUseCase
    implements UseCase<Result<PrayerTrackingEntity>, NoParams> {
  final PrayerRepository repository;

  GetTodayPrayersUseCase(this.repository);

  @override
  Future<Result<PrayerTrackingEntity>> call(NoParams params) {
    return repository.getTodayPrayers();
  }
}

/// معاملات تبديل الصلاة
class TogglePrayerParams {
  final String prayerName;
  final bool isExtra;

  TogglePrayerParams({required this.prayerName, this.isExtra = false});
}

/// حالة استخدام: تبديل حالة صلاة
class TogglePrayerUseCase
    implements UseCase<Result<PrayerTrackingEntity>, TogglePrayerParams> {
  final PrayerRepository repository;

  TogglePrayerUseCase(this.repository);

  @override
  Future<Result<PrayerTrackingEntity>> call(TogglePrayerParams params) {
    return repository.togglePrayer(params.prayerName, params.isExtra);
  }
}
