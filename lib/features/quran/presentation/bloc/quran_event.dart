import 'package:equatable/equatable.dart';

abstract class QuranEvent extends Equatable {
  const QuranEvent();
  @override
  List<Object?> get props => [];
}

class LoadQuranProgressEvent extends QuranEvent {}

class ToggleJuzEvent extends QuranEvent {
  final int juzIndex;
  const ToggleJuzEvent(this.juzIndex);
  @override
  List<Object?> get props => [juzIndex];
}

class UpdatePagesReadEvent extends QuranEvent {
  final int pages;
  const UpdatePagesReadEvent(this.pages);
  @override
  List<Object?> get props => [pages];
}

class UpdateDailyGoalEvent extends QuranEvent {
  final int pages;
  const UpdateDailyGoalEvent(this.pages);
  @override
  List<Object?> get props => [pages];
}
