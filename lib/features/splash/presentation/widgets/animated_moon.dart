import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../core/theme/app_theme.dart';

/// ويدجت الهلال المتحرك
class AnimatedMoon extends StatelessWidget {
  final double progress;

  const AnimatedMoon({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: progress,
      child: Transform.rotate(
        angle: (1 - progress) * -math.pi / 4,
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withValues(alpha: 0.5),
                blurRadius: 30,
                spreadRadius: 10,
              ),
            ],
          ),
          child: const Text(
            '🌙',
            style: TextStyle(fontSize: 80),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
