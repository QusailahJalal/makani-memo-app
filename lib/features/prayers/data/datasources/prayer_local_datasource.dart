import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/prayer_model.dart';

/// مصدر البيانات المحلي للصلوات
abstract class PrayerLocalDataSource {
  Future<PrayerTrackingModel?> getTodayPrayers(String date);
  Future<void> savePrayers(PrayerTrackingModel prayers);
}

/// تنفيذ مصدر البيانات المحلي
class PrayerLocalDataSourceImpl implements PrayerLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _key = 'prayer_tracking';

  PrayerLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<PrayerTrackingModel?> getTodayPrayers(String date) async {
    final data = sharedPreferences.getString(_key);
    if (data != null) {
      final allPrayers = jsonDecode(data) as Map<String, dynamic>;
      if (allPrayers.containsKey(date)) {
        return PrayerTrackingModel.fromJson(
          allPrayers[date] as Map<String, dynamic>,
        );
      }
    }
    return null;
  }

  @override
  Future<void> savePrayers(PrayerTrackingModel prayers) async {
    final data = sharedPreferences.getString(_key);
    Map<String, dynamic> allPrayers = {};
    if (data != null) {
      allPrayers = jsonDecode(data) as Map<String, dynamic>;
    }
    allPrayers[prayers.date] = prayers.toJson();
    await sharedPreferences.setString(_key, jsonEncode(allPrayers));
  }
}
