import 'package:flutter/material.dart';
import 'package:flutter_learn_app/ad_mob/AdMobScreen.dart';
import 'package:flutter_learn_app/dynamic_link/DynamicLink.dart';
import 'package:flutter_learn_app/localization/MyLocalizations.dart';
import 'package:flutter_learn_app/one_signal/OneSignalCode.dart';
import 'package:flutter_learn_app/pages/ApiCallUse.dart';
import 'package:flutter_learn_app/pages/BottomSheetUse.dart';
import 'package:flutter_learn_app/pages/LocalDbUse.dart';
import 'package:flutter_learn_app/pages/PreferenceUse.dart';
import 'package:flutter_learn_app/pages/PullToRefreshPaginationUse.dart';
import 'package:flutter_learn_app/view_pager/TabViewPagerUse.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../ad_mob/AdMobScreen.dart';
import '../social_login/GoogleLoginDemo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CounterWidget(),
    localizationsDelegates: [
      const MyLocalizationsDelegate(),
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
  ));
}

class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter App"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      _navigateToNewScreen(context, ApiCallUse());
                    },
                    child: Center(child: Text("ApiCall & Validation"))),
                columnSpaceWidget(),
                ElevatedButton(
                    onPressed: () {
                      _navigateToNewScreen(context, AdMobScreen());
                    },
                    child: Center(child: Text("Google AdMob"))),
                columnSpaceWidget(),
                ElevatedButton(
                    onPressed: () {
                      _navigateToNewScreen(context, GoogleLoginDemo());
                    },
                    child: Center(child: Text("Google Login"))),
                columnSpaceWidget(),
                ElevatedButton(
                    onPressed: () {
                      _navigateToNewScreen(context, BottomSheetUse());
                    },
                    child: Center(child: Text("BottomSheet"))),
                columnSpaceWidget(),
                ElevatedButton(
                    onPressed: () {
                      _navigateToNewScreen(context, LocalDbUse());
                    },
                    child: Center(child: Text("Local Database"))),
                columnSpaceWidget(),
                ElevatedButton(
                    onPressed: () {
                      _navigateToNewScreen(context, OneSignalCode());
                    },
                    child: Center(child: Text("One Signal"))),
                columnSpaceWidget(),
                ElevatedButton(
                    onPressed: () {
                      _navigateToNewScreen(context, PreferenceUse());
                    },
                    child: Center(child: Text("Shared Preference"))),
                columnSpaceWidget(),
                ElevatedButton(
                    onPressed: () {
                      _navigateToNewScreen(context, PullToRefreshPaginationUse());
                    },
                    child: Center(child: Text("PullToRefresh & Pagination"))),
                columnSpaceWidget(),
                ElevatedButton(
                    onPressed: () {
                      _navigateToNewScreen(context, TabViewPagerUse());
                    },
                    child: Center(child: Text("Tab View Pager"))),
                columnSpaceWidget(),
                ElevatedButton(
                    onPressed: () {
                      _navigateToNewScreen(context, DynamicLink());
                    },
                    child: Center(child: Text("Dynamic Link"))),
                columnSpaceWidget(),
              ],
            ),
          ),
        ));
  }

  void _navigateToNewScreen(BuildContext context, Widget newWidget) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => newWidget));
  }

  Widget columnSpaceWidget() {
    return SizedBox(height: 10);
  }
}
