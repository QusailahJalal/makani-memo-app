import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../../domain/usecases/prayer_usecases.dart';
import 'prayer_event.dart';
import 'prayer_state.dart';

/// BLoC الصلوات
class PrayerBloc extends Bloc<PrayerEvent, PrayerState> {
  final GetTodayPrayersUseCase getTodayPrayersUseCase;
  final TogglePrayerUseCase togglePrayerUseCase;

  PrayerBloc({
    required this.getTodayPrayersUseCase,
    required this.togglePrayerUseCase,
  }) : super(PrayerInitial()) {
    on<LoadTodayPrayersEvent>(_onLoadTodayPrayers);
    on<TogglePrayerEvent>(_onTogglePrayer);
  }

  Future<void> _onLoadTodayPrayers(
    LoadTodayPrayersEvent event,
    Emitter<PrayerState> emit,
  ) async {
    emit(PrayerLoading());

    final result = await getTodayPrayersUseCase(NoParams());

    if (result.isSuccess) {
      emit(PrayerLoaded(result.data!));
    } else {
      emit(PrayerError(result.failure!.message));
    }
  }

  Future<void> _onTogglePrayer(
    TogglePrayerEvent event,
    Emitter<PrayerState> emit,
  ) async {
    final result = await togglePrayerUseCase(
      TogglePrayerParams(prayerName: event.prayerName, isExtra: event.isExtra),
    );

    if (result.isSuccess) {
      emit(PrayerLoaded(result.data!));
    } else {
      emit(PrayerError(result.failure!.message));
    }
  }
}
