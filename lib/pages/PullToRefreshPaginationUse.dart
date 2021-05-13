import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learn_app/custom_widgets/CardView.dart';
import 'package:flutter_learn_app/local_db/MyDatabase.dart';
import 'package:flutter_learn_app/model/playerList.dart';
import 'package:flutter_learn_app/shimmer/ShimmerCommonListView.dart';
import 'package:flutter_learn_app/shimmer/ShimmerRowListItem.dart';
import 'package:flutter_learn_app/utilities/AppTheme.dart';
import 'package:flutter_learn_app/utilities/CommonFunctions.dart';
import 'package:flutter_learn_app/utilities/MySharedPreference.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullToRefreshPaginationUse extends StatefulWidget {
  @override
  _PullToRefreshPaginationUseState createState() =>
      _PullToRefreshPaginationUseState();
}

class _PullToRefreshPaginationUseState
    extends State<PullToRefreshPaginationUse> {
  List<PlayerList> dbGetList = [];
  final myDatabase = MyDatabase.instance;

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    getListFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PullToRefresh"),
        centerTitle: true,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: dbGetList.length == 0 ? ShimmerCommonListView(
              count: 20,
              child:ShimmerRowListItem(),
            ) : SmartRefresher(
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: true,
              child: ListView.builder(
                  itemCount: dbGetList.length,
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      child: CardView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,
                              vertical: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(dbGetList[index].playerName),
                              SizedBox(height: 2),
                              Text(dbGetList[index].playerTeam),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }

  /* this function get list of all records from database */
  void getListFromDB() async {
    await Future.delayed(Duration(
        milliseconds: 3000)); // this is only used for check shimmer concept

    dbGetList.clear();
    final dbList = await myDatabase.queryAllRows(MyDatabase.tableTest);
    dbList.forEach((element) async {
      dbGetList
          .add(new PlayerList(element["id"], element["name"], element["city"]));
      print("record id : " + element["id"]);
    });
    setState(() {});
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    dbGetList.add(new PlayerList("50", "Ter Stegen", "Barca"));
    setState(() {});
    _refreshController.loadComplete();
  }
}
