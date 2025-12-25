import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// بطاقة الصلاة
class PrayerCard extends StatelessWidget {
  final String prayerName;
  final String emoji;
  final bool isCompleted;
  final VoidCallback onTap;
  final bool isExtra;

  const PrayerCard({
    super.key,
    required this.prayerName,
    required this.emoji,
    required this.isCompleted,
    required this.onTap,
    this.isExtra = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isCompleted
              ? AppColors.success.withValues(alpha: 0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCompleted
                ? AppColors.success
                : AppColors.primary.withValues(alpha: 0.2),
            width: isCompleted ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isCompleted
                  ? AppColors.success.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isCompleted
                    ? AppColors.success.withValues(alpha: 0.2)
                    : AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prayerName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isCompleted
                          ? AppColors.success
                          : AppColors.textPrimary,
                    ),
                  ),
                  if (isExtra)
                    const Text(
                      'صلاة إضافية',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.success : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isCompleted ? AppColors.success : AppColors.textLight,
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 20)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
