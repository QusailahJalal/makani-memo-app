import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'injection_container.dart' as di;

// Features - BLoCs
import 'features/prayers/presentation/bloc/prayer_bloc.dart';
import 'features/prayers/presentation/bloc/prayer_event.dart';
import 'features/quran/presentation/bloc/quran_bloc.dart';
import 'features/quran/presentation/bloc/quran_event.dart';
import 'features/goals/presentation/bloc/goal_bloc.dart';
import 'features/goals/presentation/bloc/goal_event.dart';

// Splash Screen
import 'features/splash/presentation/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(DevicePreview(
    builder: (context) {
      return const MakaniMemoApp();
    }
  ));
}

class MakaniMemoApp extends StatelessWidget {
  const MakaniMemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<PrayerBloc>()..add(LoadTodayPrayersEvent()),
        ),
        BlocProvider(
          create: (_) => di.sl<QuranBloc>()..add(LoadQuranProgressEvent()),
        ),
        BlocProvider(create: (_) => di.sl<GoalBloc>()..add(LoadGoalsEvent())),
      ],
      child: MaterialApp(
        title: 'مذكرة مكاني الرمضانية',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        locale: const Locale('ar'),
        builder: (context, child) =>
            Directionality(textDirection: TextDirection.rtl, child: child!),
        home: const SplashScreen(),
      ),
    );
  }
}
