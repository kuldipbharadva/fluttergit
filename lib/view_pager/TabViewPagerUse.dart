import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learn_app/custom_widgets/CardView.dart';
import 'package:flutter_learn_app/navigation_drawer/NavigationScreen.dart';
import 'package:flutter_learn_app/local_db/MyDatabase.dart';
import 'package:flutter_learn_app/model/playerList.dart';
import 'package:flutter_learn_app/utilities/AppColor.dart';
import 'package:flutter_learn_app/utilities/AppTheme.dart';
import 'package:flutter_learn_app/utilities/CommonFunctions.dart';
import 'package:flutter_learn_app/utilities/MySharedPreference.dart';
import 'package:flutter_learn_app/view_pager/Tab1.dart';

class TabViewPagerUse extends StatefulWidget {
  @override
  _TabViewPagerUseState createState() => _TabViewPagerUseState();
}

class _TabViewPagerUseState extends State<TabViewPagerUse>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      // appBar: AppBar(
      //   title: Text("Tab View Pager"),
      //   centerTitle: true,
      //   elevation: 0,
      // ),
      // resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // DefaultTabController(
              //     length: 3, initialIndex: 0, child: getTabBar()),
              Container(
                height: 58,
                width: MediaQuery.of(context).size.width,
                color: AppColor.appBlueColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          _drawerKey.currentState.openDrawer();
                        }, child: Container(child: Icon(Icons.menu)))
                  ],
                ),
              ),
              getTabBar(),
              Expanded(child: getTabBarPages())
            ],
          ),
        ),
      ),
      drawer: NavigationScreen(),
    );
  }

  Widget getTabBar() {
    return TabBar(
      isScrollable: false,
      controller: _tabController,
      indicatorColor: AppColor.appBlueColor,
      labelColor: AppColor.appBlueColor,
      unselectedLabelColor: AppColor.appBlueColor.withAlpha(500),
      tabs: [
        Tab(text: "Tab 1"),
        Tab(text: "Tab 2"),
        Tab(text: "Tab 3"),
      ],
    );
  }

  Widget getTabBarPages() {
    return TabBarView(controller: _tabController, children: [
      Tab1(),
      Tab1(),
      Tab1(),
    ]);
  }

}
