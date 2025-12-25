import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quran_model.dart';

abstract class QuranLocalDataSource {
  Future<QuranProgressModel?> getQuranProgress();
  Future<void> saveQuranProgress(QuranProgressModel progress);
}

class QuranLocalDataSourceImpl implements QuranLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _key = 'quran_progress';

  QuranLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<QuranProgressModel?> getQuranProgress() async {
    final data = sharedPreferences.getString(_key);
    if (data != null) {
      return QuranProgressModel.fromJson(
        jsonDecode(data) as Map<String, dynamic>,
      );
    }
    return null;
  }

  @override
  Future<void> saveQuranProgress(QuranProgressModel progress) async {
    await sharedPreferences.setString(_key, jsonEncode(progress.toJson()));
  }
}
