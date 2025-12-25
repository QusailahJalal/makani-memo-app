import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/app_theme.dart';

/// حلقة التقدم الدائرية
class ProgressRing extends StatelessWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final Color? progressColor;
  final Color? backgroundColor;
  final Widget? child;
  final bool showPercentage;

  const ProgressRing({
    super.key,
    required this.progress,
    this.size = 120,
    this.strokeWidth = 12,
    this.progressColor,
    this.backgroundColor,
    this.child,
    this.showPercentage = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _ProgressRingPainter(
              progress: progress.clamp(0.0, 1.0),
              strokeWidth: strokeWidth,
              progressColor: progressColor ?? AppColors.primary,
              backgroundColor:
                  backgroundColor ?? AppColors.primary.withValues(alpha: 0.15),
            ),
          ),
          if (child != null)
            child!
          else if (showPercentage)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: size * 0.22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;

  _ProgressRingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.progressColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // رسم الخلفية
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // رسم التقدم
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor;
  }
}

/// حلقة تقدم متدرجة
class GradientProgressRing extends StatelessWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final List<Color>? gradientColors;
  final Widget? child;

  const GradientProgressRing({
    super.key,
    required this.progress,
    this.size = 120,
    this.strokeWidth = 12,
    this.gradientColors,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _GradientProgressRingPainter(
              progress: progress.clamp(0.0, 1.0),
              strokeWidth: strokeWidth,
              gradientColors:
                  gradientColors ??
                  [AppColors.primaryLight, AppColors.primary, AppColors.gold],
            ),
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}

class _GradientProgressRingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final List<Color> gradientColors;

  _GradientProgressRingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // رسم الخلفية
    final backgroundPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // رسم التقدم بتدرج
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = SweepGradient(
      startAngle: -math.pi / 2,
      endAngle: 3 * math.pi / 2,
      colors: gradientColors,
    );

    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(rect, -math.pi / 2, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _GradientProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
