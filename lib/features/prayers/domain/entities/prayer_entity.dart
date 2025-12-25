import 'package:equatable/equatable.dart';

/// كيان تتبع الصلوات
class PrayerTrackingEntity extends Equatable {
  final String date;
  final Map<String, bool> prayers;
  final Map<String, bool> extraPrayers;

  const PrayerTrackingEntity({
    required this.date,
    required this.prayers,
    required this.extraPrayers,
  });

  /// إنشاء كيان فارغ لليوم
  factory PrayerTrackingEntity.empty(String date) {
    return PrayerTrackingEntity(
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

  /// نسخة معدلة
  PrayerTrackingEntity copyWith({
    String? date,
    Map<String, bool>? prayers,
    Map<String, bool>? extraPrayers,
  }) {
    return PrayerTrackingEntity(
      date: date ?? this.date,
      prayers: prayers ?? Map.from(this.prayers),
      extraPrayers: extraPrayers ?? Map.from(this.extraPrayers),
    );
  }

  /// حساب نسبة الإنجاز
  double get completionPercentage {
    final total = prayers.length + extraPrayers.length;
    final completed =
        prayers.values.where((v) => v).length +
        extraPrayers.values.where((v) => v).length;
    return completed / total;
  }

  /// عدد الصلوات المكتملة
  int get completedCount {
    return prayers.values.where((v) => v).length +
        extraPrayers.values.where((v) => v).length;
  }

  /// إجمالي الصلوات
  int get totalCount => prayers.length + extraPrayers.length;

  @override
  List<Object?> get props => [date, prayers, extraPrayers];
}
