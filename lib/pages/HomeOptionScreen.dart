import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn_app/ad_mob/AdMobScreen.dart';
import 'package:flutter_learn_app/dynamic_link/DynamicLink.dart';
import 'package:flutter_learn_app/fcm/sign_in_with_google_firebase.dart';
import 'package:flutter_learn_app/fcm_module/pages/auth_screen.dart';
import 'package:flutter_learn_app/fcm_module/pages/chat_screen.dart';
import 'package:flutter_learn_app/map_module/MapScreen.dart';
import 'package:flutter_learn_app/one_signal/OneSignalCode.dart';
import 'package:flutter_learn_app/pages/BottomSheetUse.dart';
import 'package:flutter_learn_app/pages/LocalDbUse.dart';
import 'package:flutter_learn_app/pages/PreferenceUse.dart';
import 'package:flutter_learn_app/pages/PullToRefreshPaginationUse.dart';
import 'package:flutter_learn_app/social_login/GoogleLoginDemo.dart';
import 'package:flutter_learn_app/view_pager/TabViewPagerUse.dart';
import 'package:permission_handler/permission_handler.dart';

import 'ApiCallUse.dart';

class HomeOptionScreen extends StatefulWidget {
  const HomeOptionScreen({Key key}) : super(key: key);

  @override
  _HomeOptionScreenState createState() => _HomeOptionScreenState();
}

class _HomeOptionScreenState extends State<HomeOptionScreen> {

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
                      FirebaseAuth.instance
                          .authStateChanges()
                          .listen((User user) {
                        if (user == null) {
                          _navigateToNewScreen(context, AuthScreen());
                          print('User is currently signed out!');
                        } else {
                          _navigateToNewScreen(context, ChatScreen());
                          print('User is signed in!');
                        }
                      });
                    },
                    child: Center(child: Text("FCM Auth & Chat"))),
                columnSpaceWidget(),
                ElevatedButton(
                    onPressed: () {
                      _navigateToNewScreen(context, SignInWithGoogleFirebase());
                    },
                    child: Center(child: Text("FCM Mobile No & Google Auth"))),
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
                ElevatedButton(
                    onPressed: () {
                      // _navigateToNewScreen(context, MapScreen());
                      checkLocationPermission(context);
                    },
                    child: Center(child: Text("Map"))),
                columnSpaceWidget(),
              ],
            ),
          ),
        ));
  }

  checkLocationPermission(BuildContext context) async {
    PermissionStatus permissionLocation = await Permission.location.request();
    if(permissionLocation.isGranted) {
      _navigateToNewScreen(context, MapScreen());
    } else if(permissionLocation.isRestricted) {
      print("permission restricted");
    } else if(permissionLocation.isDenied) {
      print("permission denied");
    } else if(permissionLocation.isPermanentlyDenied) {
      print("permission denied always");
      openAppSettings();
    }
  }

  void _navigateToNewScreen(BuildContext context, Widget newWidget) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => newWidget));
  }

  Widget columnSpaceWidget() {
    return SizedBox(height: 10);
  }
}
