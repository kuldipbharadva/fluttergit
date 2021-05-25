import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {

  static savePreferenceValue(String key, Object value, PreferenceType preferenceType) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    switch(preferenceType) {
      case PreferenceType.STRING:
        _prefs.setString(key, value);
        break;
      case PreferenceType.INT:
        _prefs.setInt(key, value);
        break;
      case PreferenceType.DOUBLE:
        _prefs.setDouble(key, value);
        break;
      case PreferenceType.BOOL:
        _prefs.setBool(key, value);
        break;
      case PreferenceType.LIST:
        _prefs.setStringList(key, value);
        break;
      case PreferenceType.MODEL:
        _prefs.setString(key, json.encode(value));
        break;
    }
  }

  static Future<dynamic> readPreferenceValue(String key, PreferenceType preferenceType, {Object defaultValue}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    switch(preferenceType) {
      case PreferenceType.STRING:
        return _prefs.getString(key);
      case PreferenceType.INT:
        return _prefs.getInt(key) ?? 0;
      case PreferenceType.DOUBLE:
        return _prefs.getDouble(key) ?? 0.0;
      case PreferenceType.BOOL:
        return _prefs.getBool(key) ?? false;
      case PreferenceType.LIST:
        return (_prefs.getStringList(key) ?? []);
      case PreferenceType.MODEL:
        return json.decode(_prefs.getString(key));
    }
  }
  
  static removePreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

enum PreferenceType {
  STRING, INT, DOUBLE, BOOL, LIST, MODEL
}

String keyId= "Id";