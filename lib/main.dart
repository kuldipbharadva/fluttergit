import 'package:flutter/material.dart';
import 'package:flutter_learn_app/ad_mob/AdMobScreen.dart';
import 'package:flutter_learn_app/dynamic_link/DynamicLink.dart';
import 'package:flutter_learn_app/localization/MyLocalizations.dart';
import 'package:flutter_learn_app/localization/language_constants.dart';
import 'package:flutter_learn_app/one_signal/OneSignalCode.dart';
import 'package:flutter_learn_app/pages/ApiCallUse.dart';
import 'package:flutter_learn_app/pages/BottomSheetUse.dart';
import 'package:flutter_learn_app/pages/HomeOptionScreen.dart';
import 'package:flutter_learn_app/pages/LocalDbUse.dart';
import 'package:flutter_learn_app/pages/PreferenceUse.dart';
import 'package:flutter_learn_app/pages/PullToRefreshPaginationUse.dart';
import 'package:flutter_learn_app/view_pager/TabViewPagerUse.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';

import 'ad_mob/AdMobScreen.dart';
import 'map_module/MapScreen.dart';
import 'social_login/GoogleLoginDemo.dart';
import 'utilities/MySharedPreference.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {

  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    _locals.add(Locale(ENGLISH, ''));
    _locals.add(Locale(ARABIC, ''));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeOptionScreen(),
      localizationsDelegates: [
        const MyLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: _locals,
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale?.languageCode == locale?.languageCode &&
              supportedLocale?.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales?.first;
      },
    );
  }
}
