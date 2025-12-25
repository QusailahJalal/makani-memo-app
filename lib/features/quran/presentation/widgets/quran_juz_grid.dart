import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class QuranJuzGrid extends StatelessWidget {
  final List<bool> completedJuz;
  final Function(int) onJuzTap;

  const QuranJuzGrid({
    super.key,
    required this.completedJuz,
    required this.onJuzTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 30,
      itemBuilder: (context, index) {
        final isCompleted = completedJuz[index];
        return GestureDetector(
          onTap: () => onJuzTap(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              gradient: isCompleted
                  ? const LinearGradient(
                      colors: [AppColors.success, Color(0xFF2E7D32)],
                    )
                  : null,
              color: isCompleted ? null : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isCompleted
                    ? AppColors.success
                    : AppColors.primary.withValues(alpha: 0.2),
                width: isCompleted ? 0 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isCompleted
                      ? AppColors.success.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isCompleted ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
