import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/goal_entity.dart';
import '../bloc/goal_bloc.dart';
import '../bloc/goal_event.dart';
import '../bloc/goal_state.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalBloc, GoalState>(
      builder: (context, state) {
        if (state is GoalLoading)
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        if (state is GoalError)
          return Scaffold(body: Center(child: Text(state.message)));
        if (state is GoalLoaded) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildHeader(context, state)),
                if (state.goals.isEmpty)
                  SliverToBoxAdapter(child: _buildEmptyState(context))
                else
                  SliverPadding(
                    padding: const EdgeInsets.all(20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildGoalCard(context, state.goals[index]),
                        ),
                        childCount: state.goals.length,
                      ),
                    ),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _showAddGoalDialog(context),
              backgroundColor: AppColors.primary,
              icon: const Icon(Icons.add),
              label: const Text('هدف جديد'),
            ),
          );
        }
        return const Scaffold(body: SizedBox());
      },
    );
  }

  Widget _buildHeader(BuildContext context, GoalLoaded state) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        left: 20,
        right: 20,
        bottom: 30,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE65100), Color(0xFFFF9800), Color(0xFFFFB74D)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'أهداف رمضان 🎯',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            '${state.completedCount} من ${state.goals.length} هدف مكتمل',
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Container(
            height: 10,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: FractionallySizedBox(
                alignment: Alignment.centerRight,
                widthFactor: state.progress,
                child: Container(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(40),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text('🎯', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 20),
          const Text(
            'لا توجد أهداف بعد',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'أضف أهدافك الرمضانية',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(BuildContext context, GoalEntity goal) {
    return Dismissible(
      key: Key(goal.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) =>
          context.read<GoalBloc>().add(DeleteGoalEvent(goal.id)),
      child: GestureDetector(
        onTap: () => context.read<GoalBloc>().add(ToggleGoalEvent(goal.id)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: goal.isCompleted
                ? AppColors.success.withValues(alpha: 0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: goal.isCompleted
                  ? AppColors.success
                  : AppColors.primary.withValues(alpha: 0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: goal.isCompleted
                      ? AppColors.success
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: goal.isCompleted
                        ? AppColors.success
                        : AppColors.textLight,
                    width: 2,
                  ),
                ),
                child: goal.isCompleted
                    ? const Icon(Icons.check, color: Colors.white, size: 18)
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  goal.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: goal.isCompleted
                        ? AppColors.success
                        : AppColors.textPrimary,
                    decoration: goal.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddGoalDialog(BuildContext context) {
    final titleController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'هدف جديد 🎯',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'عنوان الهدف'),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (titleController.text.trim().isNotEmpty) {
                      context.read<GoalBloc>().add(
                        AddGoalEvent(title: titleController.text.trim()),
                      );
                      Navigator.pop(ctx);
                    }
                  },
                  child: const Text('إضافة الهدف'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
