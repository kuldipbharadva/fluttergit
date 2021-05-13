/*
Localizations Concept
----------------------
Copy localization folder in your app
Copy lang folder and add your string json file as per needed language
Add basic localization code in main.dart
 localizationsDelegates: [
      const MyLocalizationsDelegate(),
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],

Add following library :
flutter_localizations:
    sdk: flutter

User like : buildTranslate(context, "your json file key")
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
AdMob Concept
--------------
Add library
google_sign_in: ^5.0.1

Follow the AdMobScreen.dart code

Add following two line in main.dart file or you can initialize in particular screen
WidgetsFlutterBinding.ensureInitialized();
MobileAds.instance.initialize();

Add meta tag and internet permission in your AndroidManifest file
<meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="ca-app-pub-3940256099942544~3347511713"/> this is test appId, you can use your live
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
OneSignal
----------
Create App in firebase and add google-service.json file in android module and do basic setup like adding dependency in android module.
Create account in OneSignal platform and create project.
Get oneSignalAppId from that project and set in our code.

Follow OneSignalCode.dart code
You have to send oneSignal userId/playerId to server. // this is like fcmToken

Add following code in android app gradle top

buildscript {
    repositories {
        maven { url 'https://plugins.gradle.org/m2/' } // Gradle Plugin Portal
    }
    dependencies {
        // OneSignal-Gradle-Plugin
        classpath 'gradle.plugin.com.onesignal:onesignal-gradle-plugin:[0.12.6, 0.99.99]'
    }
}
apply plugin: 'com.onesignal.androidsdk.onesignal-gradle-plugin'

Reference url : https://pub.dev/packages/onesignal_flutter/example
Reference url : https://documentation.onesignal.com/docs/flutter-sdk-setup for iOS
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
Local Database
---------------
Add SQFlite library (use latest version)
  sqflite: ^1.3.0
  path_provider:

Add MyDatabase.dart file which has all the required common methods for CRUD operation.
You can create more function as per requirement.
Check usage in LocalDbUse.dart file.
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
Shared Preference
------------------
Add library to use shared preference
  shared_preferences: 2.0.5

Add MySharedPreference.dart file in your project, this file have common function of preference.
Simply check the usage in PreferenceUse.dart file.
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
PullToRefresh & Pagination
---------------------------
Add library :
  pull_to_refresh: 1.6.5

Just check usage of this concept in PullToRefreshPaginationUse.dart

Reference link : https://pub.dev/packages/pull_to_refresh
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
ShimmerView
---------------------------
Add library :
  shimmer: ^1.1.2

Just check usage of this concept in PullToRefreshPaginationUse.dart
You can create your shimmer item as per your design, you can refer ShimmerRowGridItem.dart, ShimmerRowListItem.dart
You can also create another common view for shimmer like ShimmerCommonListView.dart.
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
Navigation Drawer
------------------
To use or create Navigation drawer in your flutter project first need to create navigation screen,
You can copy NavigationScreen.dart file and make changes as per your drawer design.

To open drawer when click on menu icon just use below code:
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  onTap: () {
    _drawerKey.currentState.openDrawer();
  }

assign '_drawerKey' to scaffold,
Also add in scaffold : drawer: NavigationScreen()
You can refer check full usage in TabViewPagerUse.dart file.
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
Tab View Pager
---------------
You can refer check full usage in TabViewPagerUse.dart file.
I have use tab view without appbar so you can easily customise your header.
Don't forget to add below line:
  with SingleTickerProviderStateMixin
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
Firebase DynamicLink
---------------------
Very easy to implement,
First you need to create dynamic link domain url in firebase console project, if project not created then do it first,
Then initialize your dynamic link code,
You can use DynamicLinkHelper.dart class to create link or you can refer DynamicLink.dart code.

You have to do some platform dependent code like add Intent-filter in android manifest,
Reference link : https://pub.dev/packages/firebase_dynamic_links
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
Google Login
---------------------
Create project in google developer console and enable GMAIL api and also enable Google people api for image and other info,
Then goto firebase console and create project if you have not done, then enable google in authentication tab,
Make sure you have placed latest google-service.json file in your android app module.
Then refer GoogleLoginDemo.dart class and you can modify code as per your need and easiness.
Reference link : https://pub.dev/packages/google_sign_in/example
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
