import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learn_app/utilities/MySharedPreference.dart';

import '../main.dart';

class MyLocalizations {
  MyLocalizations(this.locale);

  final Locale locale;

  static MyLocalizations of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    print("set locale ::::: " + locale.languageCode.toString());
    String jsonString = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));

    if (_localizedStrings.length == 0) {
      String jsonString = await rootBundle.loadString('assets/lang/en.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      _localizedStrings = jsonMap.map((key, value) {
        return MapEntry(key, value.toString());
      });
    }
    return true;
  }

  String getString(String key) {
    return _localizedStrings[key];
  }
}

String buildTranslate(BuildContext context, String key) =>
    MyLocalizations.of(context).getString(key);

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  const MyLocalizationsDelegate();

  /*@override
  bool isSupported(Locale locale) => true;*/
  @override
  bool isSupported(Locale locale) {
    List<String> _languageString = [];
    _languageString.add('en');
    _languageString.add('ar');
    return _languageString.contains(locale.languageCode);
  }

  @override
  Future<MyLocalizations> load(Locale locale) async {
    MyLocalizations localizations = new MyLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}


const String prefSelectedLanguageCode = "SelectedLanguageCode";

Future<Locale> setLocale(String languageCode) async {
  await MySharedPreference.savePreferenceValue("langCode", languageCode, PreferenceType.STRING);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  String languageCode = await MySharedPreference.readPreferenceValue("langCode", PreferenceType.STRING) ?? "en";
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  return languageCode != null && languageCode.isNotEmpty ? Locale(languageCode, '') : Locale('en', '');
}

void changeLanguage(BuildContext context, String selectedLanguageCode) async {
  var _locale = await setLocale(selectedLanguageCode);
  MyApp.setLocale(context, _locale);
}