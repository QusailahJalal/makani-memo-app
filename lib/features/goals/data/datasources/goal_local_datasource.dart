import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/goal_model.dart';

abstract class GoalLocalDataSource {
  Future<List<GoalModel>> getGoals();
  Future<void> saveGoals(List<GoalModel> goals);
}

class GoalLocalDataSourceImpl implements GoalLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _key = 'ramadan_goals';

  GoalLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<GoalModel>> getGoals() async {
    final data = sharedPreferences.getString(_key);
    if (data != null) {
      final list = jsonDecode(data) as List;
      return list
          .map((e) => GoalModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<void> saveGoals(List<GoalModel> goals) async {
    await sharedPreferences.setString(
      _key,
      jsonEncode(goals.map((g) => g.toJson()).toList()),
    );
  }
}
