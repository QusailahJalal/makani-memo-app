import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../../domain/usecases/quran_usecases.dart';
import 'quran_event.dart';
import 'quran_state.dart';

class QuranBloc extends Bloc<QuranEvent, QuranState> {
  final GetQuranProgressUseCase getQuranProgressUseCase;
  final ToggleJuzUseCase toggleJuzUseCase;
  final UpdatePagesReadUseCase updatePagesReadUseCase;
  final UpdateDailyGoalUseCase updateDailyGoalUseCase;

  QuranBloc({
    required this.getQuranProgressUseCase,
    required this.toggleJuzUseCase,
    required this.updatePagesReadUseCase,
    required this.updateDailyGoalUseCase,
  }) : super(QuranInitial()) {
    on<LoadQuranProgressEvent>(_onLoad);
    on<ToggleJuzEvent>(_onToggleJuz);
    on<UpdatePagesReadEvent>(_onUpdatePagesRead);
    on<UpdateDailyGoalEvent>(_onUpdateDailyGoal);
  }

  Future<void> _onLoad(
    LoadQuranProgressEvent event,
    Emitter<QuranState> emit,
  ) async {
    emit(QuranLoading());
    final result = await getQuranProgressUseCase(NoParams());
    if (result.isSuccess) {
      emit(QuranLoaded(result.data!));
    } else {
      emit(QuranError(result.failure!.message));
    }
  }

  Future<void> _onToggleJuz(
    ToggleJuzEvent event,
    Emitter<QuranState> emit,
  ) async {
    final result = await toggleJuzUseCase(ToggleJuzParams(event.juzIndex));
    if (result.isSuccess) {
      emit(QuranLoaded(result.data!));
    } else {
      emit(QuranError(result.failure!.message));
    }
  }

  Future<void> _onUpdatePagesRead(
    UpdatePagesReadEvent event,
    Emitter<QuranState> emit,
  ) async {
    final result = await updatePagesReadUseCase(event.pages);
    if (result.isSuccess) {
      emit(QuranLoaded(result.data!));
    }
  }

  Future<void> _onUpdateDailyGoal(
    UpdateDailyGoalEvent event,
    Emitter<QuranState> emit,
  ) async {
    final result = await updateDailyGoalUseCase(event.pages);
    if (result.isSuccess) {
      emit(QuranLoaded(result.data!));
    }
  }
}
