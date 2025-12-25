import '../entities/prayer_entity.dart';
import '../../../../core/usecases/base_usecase.dart';

/// واجهة مستودع الصلوات
abstract class PrayerRepository {
  /// الحصول على صلوات اليوم
  Future<Result<PrayerTrackingEntity>> getTodayPrayers();

  /// تبديل حالة صلاة
  Future<Result<PrayerTrackingEntity>> togglePrayer(
    String prayerName,
    bool isExtra,
  );

  /// حفظ الصلوات
  Future<Result<void>> savePrayers(PrayerTrackingEntity prayers);
}
