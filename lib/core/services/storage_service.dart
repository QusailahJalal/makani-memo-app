import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// خدمة التخزين المحلي
class StorageService {
  static SharedPreferences? _prefs;

  /// تهيئة الخدمة
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// حفظ البيانات
  static Future<bool> saveData(String key, dynamic data) async {
    if (_prefs == null) await init();

    if (data is String) {
      return await _prefs!.setString(key, data);
    } else if (data is int) {
      return await _prefs!.setInt(key, data);
    } else if (data is double) {
      return await _prefs!.setDouble(key, data);
    } else if (data is bool) {
      return await _prefs!.setBool(key, data);
    } else if (data is List<String>) {
      return await _prefs!.setStringList(key, data);
    } else {
      // تحويل الكائنات المعقدة إلى JSON
      return await _prefs!.setString(key, jsonEncode(data));
    }
  }

  /// استرجاع نص
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  /// استرجاع رقم صحيح
  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  /// استرجاع رقم عشري
  static double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  /// استرجاع قيمة منطقية
  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  /// استرجاع قائمة نصوص
  static List<String>? getStringList(String key) {
    return _prefs?.getStringList(key);
  }

  /// استرجاع كائن JSON
  static Map<String, dynamic>? getJson(String key) {
    final data = _prefs?.getString(key);
    if (data != null) {
      return jsonDecode(data) as Map<String, dynamic>;
    }
    return null;
  }

  /// حذف مفتاح
  static Future<bool> remove(String key) async {
    if (_prefs == null) await init();
    return await _prefs!.remove(key);
  }

  /// مسح جميع البيانات
  static Future<bool> clear() async {
    if (_prefs == null) await init();
    return await _prefs!.clear();
  }

  /// التحقق من وجود مفتاح
  static bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }
}

/// مفاتيح التخزين
class StorageKeys {
  static const String prayerTracking = 'prayer_tracking';
  static const String quranProgress = 'quran_progress';
  static const String ramadanGoals = 'ramadan_goals';
  static const String dailyReflections = 'daily_reflections';
  static const String completedDays = 'completed_days';
  static const String currentDay = 'current_day';
}
