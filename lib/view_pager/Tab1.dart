import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learn_app/custom_widgets/CardView.dart';
import 'package:flutter_learn_app/local_db/MyDatabase.dart';
import 'package:flutter_learn_app/model/playerList.dart';
import 'package:flutter_learn_app/utilities/AppTheme.dart';
import 'package:flutter_learn_app/utilities/CommonFunctions.dart';
import 'package:flutter_learn_app/utilities/MySharedPreference.dart';

class Tab1 extends StatefulWidget {
  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(child: Text("Tab 1")),
      ),
    );
  }
}
