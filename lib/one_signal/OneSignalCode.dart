import 'dart:io';

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalCode extends StatefulWidget {
  @override
  _OneSignalCodeState createState() => _OneSignalCodeState();
}

class _OneSignalCodeState extends State<OneSignalCode> {

  String userId = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initPlatformStateOneSignal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("One Signal"),
        centerTitle: true,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("UserId/PlayerId :: $userId")
            ],
          ),
        ),
      ),
    );
  }

  /* in home screen this method need to use and send user id every time in server */
  Future<void> initPlatformStateOneSignal() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    String userId = status.subscriptionStatus.userId;
    print("OneSignalUserId :: " + userId);
    setState(() {
      this.userId = userId;
    });
    // apiCall(userId); send this userId to server
  }

  /* in splash screen following methods need to use for notification */
  Future<void> initPlatformState() async {
    if (!mounted) return;

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.consentGranted(true);
    OneSignal.shared.setRequiresUserPrivacyConsent(true);

    OneSignal.shared.init(oneSignalAppId, iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: false
    });
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    if (Platform.isIOS)
      await OneSignal.shared
          .promptUserForPushNotificationPermission(fallbackToSettings: true);

    var status = await OneSignal.shared.getPermissionSubscriptionState();

    String userid = status.subscriptionStatus.userId;
    print("OneSignalUserId while init platform :: " + userid);

    OneSignal.shared
        .setNotificationReceivedHandler(_handleNotificationReceived);

    OneSignal.shared.setNotificationOpenedHandler((openedResult) async {
      print("============" +
          openedResult.notification
              .jsonRepresentation()
              .replaceAll("\\n", "\n"));
      //print("============"+openedResult.notification.payload.launchUrl);
      //Map<String,dynamic> data=openedResult.notification.payload.additionalData;
      //print("============"+data.toString());

      Map<String, dynamic> additionalParam =
          openedResult.notification.payload.additionalData;

      print("additionalParam ========== " + additionalParam.toString());

      /*if (additionalParam.containsKey("NotificationType")) {
        String notificationType =
        additionalParam["NotificationType"].toString();

        if (notificationType == "2" ||
            notificationType == "3" ||
            notificationType == "4") {
          //print("additionalParam ========== IF");

          navigatorKey.currentState.pushReplacement(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  HomeScreen(
                    tabIndex: 1,
                  ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              }));
        } else if (notificationType == "5") {
          //print("additionalParam ========== ELSE IF");
          navigatorKey.currentState.pushReplacement(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  HomeScreen(
                    tabIndex: 2,
                  ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              }));
        } else if (notificationType == "6" ||
            notificationType == "7" ||
            notificationType == "8") {
          {
            //print("additionalParam ========== ELSE IF 2");
            navigatorKey.currentState.pushReplacement(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    HomeScreen(
                      tabIndex: 0,
                    ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return child;
                }));
          }
        }
      }*/
    });
  }

  void _handleNotificationReceived(OSNotification notification) {
  }
}
const String oneSignalAppId= "a834f4d2-50de-404a-8cc4-fc6987f19330"; // FlutterLearnApp using ilaxo account
