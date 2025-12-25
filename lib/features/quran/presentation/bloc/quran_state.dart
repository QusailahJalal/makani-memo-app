import 'package:equatable/equatable.dart';
import '../../domain/entities/quran_entity.dart';

abstract class QuranState extends Equatable {
  const QuranState();
  @override
  List<Object?> get props => [];
}

class QuranInitial extends QuranState {}

class QuranLoading extends QuranState {}

class QuranLoaded extends QuranState {
  final QuranProgressEntity progress;
  const QuranLoaded(this.progress);
  @override
  List<Object?> get props => [progress];
}

class QuranError extends QuranState {
  final String message;
  const QuranError(this.message);
  @override
  List<Object?> get props => [message];
}
