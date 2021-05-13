import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_learn_app/pages/main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobScreen extends StatefulWidget {
  @override
  _AdMobScreenState createState() => _AdMobScreenState();
}

class _AdMobScreenState extends State<AdMobScreen> {
  BannerAd myBanner;

  @override
  void initState() {
    super.initState();
    // WidgetsFlutterBinding.ensureInitialized();
    // MobileAds.instance.initialize();
    myBanner = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: AdListener(),
    );
    myBanner.load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google AdMob"),
        centerTitle: true,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              alignment: Alignment.center,
              child: AdWidget(ad: myBanner),
              width: myBanner.size.width.toDouble(),
              height: myBanner.size.height.toDouble(),
            ),
          )
        ],
      ),
    );
  }


  String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return null;
  }

  String getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }
    return null;
  }

  String getRewardBasedVideoAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    }
    return null;
  }
}

// Reference :: https://pub.dev/packages/admob_flutter/example
