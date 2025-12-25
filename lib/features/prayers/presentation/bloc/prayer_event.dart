import 'package:equatable/equatable.dart';

/// أحداث BLoC الصلوات
abstract class PrayerEvent extends Equatable {
  const PrayerEvent();

  @override
  List<Object?> get props => [];
}

/// تحميل صلوات اليوم
class LoadTodayPrayersEvent extends PrayerEvent {}

/// تبديل حالة صلاة
class TogglePrayerEvent extends PrayerEvent {
  final String prayerName;
  final bool isExtra;

  const TogglePrayerEvent({required this.prayerName, this.isExtra = false});

  @override
  List<Object?> get props => [prayerName, isExtra];
}
