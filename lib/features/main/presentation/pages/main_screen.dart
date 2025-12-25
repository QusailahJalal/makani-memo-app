import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

// Pages
import '../../../prayers/presentation/pages/prayers_page.dart';
import '../../../quran/presentation/pages/quran_page.dart';
import '../../../goals/presentation/pages/goals_page.dart';
import '../../../duas/presentation/pages/duas_page.dart';
import '../../../home/presentation/pages/home_page.dart';

/// الشاشة الرئيسية مع شريط التنقل السفلي
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const PrayersPage(),
    const QuranPage(),
    const GoalsPage(),
    const DuasPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_rounded, 'الرئيسية'),
                _buildNavItem(1, Icons.access_time, 'الصلوات'),
                _buildNavItem(2, Icons.menu_book_rounded, 'القرآن'),
                _buildNavItem(3, Icons.flag_rounded, 'الأهداف'),
                _buildNavItem(4, Icons.favorite_rounded, 'الأدعية'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textLight,
              size: isSelected ? 26 : 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.primary : AppColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
