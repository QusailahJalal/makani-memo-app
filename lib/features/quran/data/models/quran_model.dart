import '../../domain/entities/quran_entity.dart';

class QuranProgressModel extends QuranProgressEntity {
  const QuranProgressModel({
    required super.completedJuz,
    super.dailyGoalPages,
    super.pagesReadToday,
    required super.lastReadDate,
  });

  factory QuranProgressModel.fromJson(Map<String, dynamic> json) {
    return QuranProgressModel(
      completedJuz: List<bool>.from(json['completedJuz'] as List),
      dailyGoalPages: json['dailyGoalPages'] as int? ?? 20,
      pagesReadToday: json['pagesReadToday'] as int? ?? 0,
      lastReadDate: json['lastReadDate'] as String,
    );
  }

  factory QuranProgressModel.fromEntity(QuranProgressEntity entity) {
    return QuranProgressModel(
      completedJuz: List.from(entity.completedJuz),
      dailyGoalPages: entity.dailyGoalPages,
      pagesReadToday: entity.pagesReadToday,
      lastReadDate: entity.lastReadDate,
    );
  }

  factory QuranProgressModel.empty() {
    return QuranProgressModel(
      completedJuz: List.filled(30, false),
      dailyGoalPages: 20,
      pagesReadToday: 0,
      lastReadDate: DateTime.now().toIso8601String().split('T')[0],
    );
  }

  Map<String, dynamic> toJson() => {
    'completedJuz': completedJuz,
    'dailyGoalPages': dailyGoalPages,
    'pagesReadToday': pagesReadToday,
    'lastReadDate': lastReadDate,
  };
}
