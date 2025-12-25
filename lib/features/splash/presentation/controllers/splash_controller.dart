import 'package:flutter/material.dart';

/// كنترولر شاشة البداية
class SplashController extends ChangeNotifier {
  double _moonProgress = 0;
  double _fadeProgress = 0;
  double _scaleProgress = 0.5;
  double _starsProgress = 0.3;
  bool _isNavigating = false;

  double get moonProgress => _moonProgress;
  double get fadeProgress => _fadeProgress;
  double get scaleProgress => _scaleProgress;
  double get starsProgress => _starsProgress;
  bool get shouldNavigate => _isNavigating;

  late AnimationController _moonController;
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _starsController;

  void initialize(TickerProvider vsync) {
    // أنيميشن الهلال
    _moonController =
        AnimationController(
          duration: const Duration(milliseconds: 1500),
          vsync: vsync,
        )..addListener(() {
          _moonProgress = Curves.easeOutBack.transform(_moonController.value);
          notifyListeners();
        });

    // أنيميشن الظهور التدريجي
    _fadeController =
        AnimationController(
          duration: const Duration(milliseconds: 1000),
          vsync: vsync,
        )..addListener(() {
          _fadeProgress = Curves.easeIn.transform(_fadeController.value);
          notifyListeners();
        });

    // أنيميشن التكبير
    _scaleController =
        AnimationController(
          duration: const Duration(milliseconds: 800),
          vsync: vsync,
        )..addListener(() {
          _scaleProgress =
              0.5 + (0.5 * Curves.elasticOut.transform(_scaleController.value));
          notifyListeners();
        });

    // أنيميشن النجوم
    _starsController =
        AnimationController(
            duration: const Duration(milliseconds: 2000),
            vsync: vsync,
          )
          ..addListener(() {
            _starsProgress =
                0.3 +
                (0.7 * Curves.easeInOut.transform(_starsController.value));
            notifyListeners();
          })
          ..repeat(reverse: true);

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _moonController.forward();

    await Future.delayed(const Duration(milliseconds: 500));
    _fadeController.forward();
    _scaleController.forward();

    await Future.delayed(const Duration(milliseconds: 2500));
    _isNavigating = true;
    notifyListeners();
  }

  @override
  void dispose() {
    _moonController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    _starsController.dispose();
    super.dispose();
  }
}
