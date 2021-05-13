import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_learn_app/pages/ApiCallUse.dart';
import 'package:flutter_learn_app/utilities/AppColor.dart';

class NavigationScreen extends StatefulWidget {
  @override
  NavigationScreenState createState() => NavigationScreenState();
}

class NavigationScreenState extends State<NavigationScreen> {
  bool showMenu = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColor.appColor,
        child: Drawer(
          /// Add a ListView to the drawer. This ensures the user can scroll
          /// through the options in the drawer if there isn't enough vertical
          /// space to fit everything.
          child: ListView(
            /// Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                child: Column(
                  children: [
                    // DrawerHeader(),
                    ListTile(
                      title: Row(
                        children: [
                          Text(
                            "Home",
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).pushReplacement(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ApiCallUse(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return child;
                          },
                        ));
                      },
                    ),

                    ListTile(
                      title: Row(
                        children: [
                          Text(
                            "Google AdMob",
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        // you can do your redirection
                      },
                    ),

                    ListTile(
                      title: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            //color: Colors.green,
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.share, color: AppColor.appColor),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Share",
                              style: TextStyle(
                                fontFamily: 'AppSemiBold',
                                fontSize: 18,
                                color: AppColor.appColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        String shareText =
                            "I have been using this app and I think you might like it. Check it out on your phone: https://yourapp.page.link/share";
                        // Share.share(shareText);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
