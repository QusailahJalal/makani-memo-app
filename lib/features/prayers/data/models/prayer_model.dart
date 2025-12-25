import '../../domain/entities/prayer_entity.dart';

/// نموذج تتبع الصلوات للطبقة البيانية
class PrayerTrackingModel extends PrayerTrackingEntity {
  const PrayerTrackingModel({
    required super.date,
    required super.prayers,
    required super.extraPrayers,
  });

  /// تحويل من JSON
  factory PrayerTrackingModel.fromJson(Map<String, dynamic> json) {
    return PrayerTrackingModel(
      date: json['date'] as String,
      prayers: Map<String, bool>.from(json['prayers'] as Map),
      extraPrayers: Map<String, bool>.from(json['extraPrayers'] as Map),
    );
  }

  /// تحويل من الكيان
  factory PrayerTrackingModel.fromEntity(PrayerTrackingEntity entity) {
    return PrayerTrackingModel(
      date: entity.date,
      prayers: Map.from(entity.prayers),
      extraPrayers: Map.from(entity.extraPrayers),
    );
  }

  /// تحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {'date': date, 'prayers': prayers, 'extraPrayers': extraPrayers};
  }

  /// إنشاء نموذج فارغ
  factory PrayerTrackingModel.empty(String date) {
    return PrayerTrackingModel(
      date: date,
      prayers: const {
        'الفجر': false,
        'الظهر': false,
        'العصر': false,
        'المغرب': false,
        'العشاء': false,
      },
      extraPrayers: const {'التراويح': false, 'القيام': false, 'الوتر': false},
    );
  }
}
