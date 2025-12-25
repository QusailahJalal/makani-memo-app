import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../main/presentation/pages/main_screen.dart';
import '../controllers/splash_controller.dart';
import '../widgets/twinkling_stars.dart';
import '../widgets/animated_moon.dart';

/// شاشة البداية مع الأنيميشن
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late SplashController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SplashController();
    _controller.initialize(this);
    _controller.addListener(_checkNavigation);
  }

  void _checkNavigation() {
    if (_controller.shouldNavigate && mounted) {
      _controller.removeListener(_checkNavigation);
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MainScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(gradient: AppColors.nightGradient),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // النجوم المتلألئة
                TwinklingStars(starsProgress: _controller.starsProgress),

                // المحتوى الرئيسي
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // الهلال
                    AnimatedMoon(progress: _controller.moonProgress),

                    const SizedBox(height: 40),

                    // اسم التطبيق
                    _buildAppTitle(),

                    const SizedBox(height: 60),

                    // مؤشر التحميل
                    _buildLoadingIndicator(),
                  ],
                ),

                // النص السفلي
                _buildBottomText(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppTitle() {
    return Opacity(
      opacity: _controller.fadeProgress,
      child: Transform.translate(
        offset: Offset(0, 20 * (1 - _controller.fadeProgress)),
        child: Column(
          children: [
            Text(
              'مذكرة مكاني',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: AppColors.gold.withValues(alpha: 0.5),
                    blurRadius: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'الرمضانية',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w300,
                color: AppColors.gold,
                letterSpacing: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Transform.scale(
      scale: _controller.scaleProgress,
      child: Opacity(
        opacity: _controller.fadeProgress,
        child: SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.gold.withValues(alpha: 0.8),
            ),
            strokeWidth: 3,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomText() {
    return Positioned(
      bottom: 50,
      child: Opacity(
        opacity: _controller.fadeProgress * 0.7,
        child: const Text(
          '✨ رمضان كريم ✨',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
