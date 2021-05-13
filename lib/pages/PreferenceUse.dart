import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learn_app/custom_widgets/CardView.dart';
import 'package:flutter_learn_app/local_db/MyDatabase.dart';
import 'package:flutter_learn_app/model/playerList.dart';
import 'package:flutter_learn_app/utilities/AppTheme.dart';
import 'package:flutter_learn_app/utilities/CommonFunctions.dart';
import 'package:flutter_learn_app/utilities/MySharedPreference.dart';

class PreferenceUse extends StatefulWidget {
  @override
  _PreferenceUseState createState() => _PreferenceUseState();
}

class _PreferenceUseState extends State<PreferenceUse> {
  int i;
  double d;
  String s;
  bool b;

  @override
  void initState() {
    super.initState();
    preferenceUse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preference"),
        centerTitle: true,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Preference String :: $s"),
              SizedBox(height: 16),
              Text("Preference Int :: $i"),
              SizedBox(height: 16),
              Text("Preference Double :: $d"),
              SizedBox(height: 16),
              Text("Preference Bool :: $b"),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  preferenceUse() async {
    await MySharedPreference.savePreferenceValue("in", 10, PreferenceType.INT);
    await MySharedPreference.savePreferenceValue(
        "dbl", 10.0, PreferenceType.DOUBLE);
    await MySharedPreference.savePreferenceValue(
        "str", "10", PreferenceType.STRING);
    await MySharedPreference.savePreferenceValue(
        "bl", true, PreferenceType.BOOL);
    await MySharedPreference.savePreferenceValue(
        "bol", true, PreferenceType.BOOL);
    i = await MySharedPreference.readPreferenceValue("in", PreferenceType.INT);
    d = await MySharedPreference.readPreferenceValue(
        "dbl", PreferenceType.DOUBLE);
    s = await MySharedPreference.readPreferenceValue(
        "str", PreferenceType.STRING);
    b = await MySharedPreference.readPreferenceValue("bl", PreferenceType.BOOL);

    setState(() {
      print("pref val int : $i");
      print("pref val double : $d");
      print("pref val string : $s");
      print("pref val bool : $b");
    });
  }
}
