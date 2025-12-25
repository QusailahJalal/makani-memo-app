import 'package:equatable/equatable.dart';
import '../../domain/entities/prayer_entity.dart';

/// حالات BLoC الصلوات
abstract class PrayerState extends Equatable {
  const PrayerState();

  @override
  List<Object?> get props => [];
}

/// الحالة الابتدائية
class PrayerInitial extends PrayerState {}

/// جاري التحميل
class PrayerLoading extends PrayerState {}

/// تم التحميل بنجاح
class PrayerLoaded extends PrayerState {
  final PrayerTrackingEntity prayers;

  const PrayerLoaded(this.prayers);

  @override
  List<Object?> get props => [prayers];
}

/// حدث خطأ
class PrayerError extends PrayerState {
  final String message;

  const PrayerError(this.message);

  @override
  List<Object?> get props => [message];
}
