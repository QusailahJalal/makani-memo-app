import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../bloc/prayer_bloc.dart';
import '../bloc/prayer_event.dart';
import '../bloc/prayer_state.dart';
import '../widgets/prayer_card.dart';
import '../../../../core/widgets/progress_ring.dart';

/// شاشة تتبع الصلوات
class PrayersPage extends StatelessWidget {
  const PrayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerBloc, PrayerState>(
      builder: (context, state) {
        if (state is PrayerLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is PrayerError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }

        if (state is PrayerLoaded) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                // الهيدر
                SliverToBoxAdapter(child: _buildHeader(context, state)),

                // الصلوات الخمس
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'الصلوات الخمس',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...AppConstants.prayerNames.map((prayer) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: PrayerCard(
                              prayerName: prayer,
                              emoji: AppConstants.prayerEmojis[prayer] ?? '🕌',
                              isCompleted:
                                  state.prayers.prayers[prayer] ?? false,
                              onTap: () => context.read<PrayerBloc>().add(
                                TogglePrayerEvent(prayerName: prayer),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                // الصلوات الإضافية
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'صلوات رمضان',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.gold.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                '✨ سُنة',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.gold,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ...AppConstants.extraPrayers.map((prayer) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: PrayerCard(
                              prayerName: prayer,
                              emoji: AppConstants.prayerEmojis[prayer] ?? '🕌',
                              isCompleted:
                                  state.prayers.extraPrayers[prayer] ?? false,
                              onTap: () => context.read<PrayerBloc>().add(
                                TogglePrayerEvent(
                                  prayerName: prayer,
                                  isExtra: true,
                                ),
                              ),
                              isExtra: true,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
          );
        }

        return const Scaffold(body: SizedBox());
      },
    );
  }

  Widget _buildHeader(BuildContext context, PrayerLoaded state) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        left: 20,
        right: 20,
        bottom: 30,
      ),
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'صلوات اليوم 🕌',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'تابع صلواتك اليومية',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
          ProgressRing(
            progress: state.prayers.completionPercentage,
            size: 80,
            strokeWidth: 8,
            progressColor: AppColors.gold,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${state.prayers.completedCount}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '/${state.prayers.totalCount}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
