import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Prayers Feature
import 'features/prayers/data/datasources/prayer_local_datasource.dart';
import 'features/prayers/data/repositories/prayer_repository_impl.dart';
import 'features/prayers/domain/repositories/prayer_repository.dart';
import 'features/prayers/domain/usecases/prayer_usecases.dart';
import 'features/prayers/presentation/bloc/prayer_bloc.dart';

// Quran Feature
import 'features/quran/data/datasources/quran_local_datasource.dart';
import 'features/quran/data/repositories/quran_repository_impl.dart';
import 'features/quran/domain/repositories/quran_repository.dart';
import 'features/quran/domain/usecases/quran_usecases.dart';
import 'features/quran/presentation/bloc/quran_bloc.dart';

// Goals Feature
import 'features/goals/data/datasources/goal_local_datasource.dart';
import 'features/goals/data/repositories/goal_repository_impl.dart';
import 'features/goals/domain/repositories/goal_repository.dart';
import 'features/goals/presentation/bloc/goal_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //! Features - Prayers
  // Data sources
  sl.registerLazySingleton<PrayerLocalDataSource>(
    () => PrayerLocalDataSourceImpl(sl()),
  );
  // Repositories
  sl.registerLazySingleton<PrayerRepository>(() => PrayerRepositoryImpl(sl()));
  // Use cases
  sl.registerLazySingleton(() => GetTodayPrayersUseCase(sl()));
  sl.registerLazySingleton(() => TogglePrayerUseCase(sl()));
  // BLoC
  sl.registerFactory(
    () => PrayerBloc(getTodayPrayersUseCase: sl(), togglePrayerUseCase: sl()),
  );

  //! Features - Quran
  // Data sources
  sl.registerLazySingleton<QuranLocalDataSource>(
    () => QuranLocalDataSourceImpl(sl()),
  );
  // Repositories
  sl.registerLazySingleton<QuranRepository>(() => QuranRepositoryImpl(sl()));
  // Use cases
  sl.registerLazySingleton(() => GetQuranProgressUseCase(sl()));
  sl.registerLazySingleton(() => ToggleJuzUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePagesReadUseCase(sl()));
  sl.registerLazySingleton(() => UpdateDailyGoalUseCase(sl()));
  // BLoC
  sl.registerFactory(
    () => QuranBloc(
      getQuranProgressUseCase: sl(),
      toggleJuzUseCase: sl(),
      updatePagesReadUseCase: sl(),
      updateDailyGoalUseCase: sl(),
    ),
  );

  //! Features - Goals
  // Data sources
  sl.registerLazySingleton<GoalLocalDataSource>(
    () => GoalLocalDataSourceImpl(sl()),
  );
  // Repositories
  sl.registerLazySingleton<GoalRepository>(() => GoalRepositoryImpl(sl()));
  // BLoC
  sl.registerFactory(() => GoalBloc(repository: sl()));
}
