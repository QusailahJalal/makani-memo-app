import 'package:equatable/equatable.dart';

/// كيان تقدم القرآن
class QuranProgressEntity extends Equatable {
  final List<bool> completedJuz;
  final int dailyGoalPages;
  final int pagesReadToday;
  final String lastReadDate;

  const QuranProgressEntity({
    required this.completedJuz,
    this.dailyGoalPages = 20,
    this.pagesReadToday = 0,
    required this.lastReadDate,
  });

  factory QuranProgressEntity.empty() {
    return QuranProgressEntity(
      completedJuz: List.filled(30, false),
      dailyGoalPages: 20,
      pagesReadToday: 0,
      lastReadDate: DateTime.now().toIso8601String().split('T')[0],
    );
  }

  QuranProgressEntity copyWith({
    List<bool>? completedJuz,
    int? dailyGoalPages,
    int? pagesReadToday,
    String? lastReadDate,
  }) {
    return QuranProgressEntity(
      completedJuz: completedJuz ?? List.from(this.completedJuz),
      dailyGoalPages: dailyGoalPages ?? this.dailyGoalPages,
      pagesReadToday: pagesReadToday ?? this.pagesReadToday,
      lastReadDate: lastReadDate ?? this.lastReadDate,
    );
  }

  int get completedJuzCount => completedJuz.where((j) => j).length;
  double get completionPercentage => completedJuzCount / 30;
  bool get isKhatmCompleted => completedJuzCount == 30;
  double get dailyProgressPercentage {
    if (dailyGoalPages == 0) return 1.0;
    return (pagesReadToday / dailyGoalPages).clamp(0.0, 1.0);
  }

  @override
  List<Object?> get props => [
    completedJuz,
    dailyGoalPages,
    pagesReadToday,
    lastReadDate,
  ];
}
