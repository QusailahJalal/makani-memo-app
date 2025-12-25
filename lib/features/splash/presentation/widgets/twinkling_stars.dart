import 'package:flutter/material.dart';
import 'dart:math' as math;

/// ويدجت النجوم المتلألئة
class TwinklingStars extends StatelessWidget {
  final double starsProgress;
  final int count;

  const TwinklingStars({
    super.key,
    required this.starsProgress,
    this.count = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(count, (index) => _buildStar(context, index)),
    );
  }

  Widget _buildStar(BuildContext context, int index) {
    final random = math.Random(index);
    final size = 2.0 + random.nextDouble() * 3;
    final left = random.nextDouble() * MediaQuery.of(context).size.width;
    final top = random.nextDouble() * MediaQuery.of(context).size.height * 0.6;
    final delay = random.nextDouble();
    final animValue = ((starsProgress + delay) % 1.0);

    return Positioned(
      left: left,
      top: top,
      child: Opacity(
        opacity: animValue,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.5),
                blurRadius: size,
                spreadRadius: size / 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
