import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learn_app/dynamic_link/DynamicLinkHelper.dart';
import 'package:url_launcher/url_launcher.dart';

class DynamicLink extends StatefulWidget {
  @override
  _DynamicLinkState createState() => _DynamicLinkState();
}

class _DynamicLinkState extends State<DynamicLink> {
  String _linkMessage;
  bool _isCreatingLink = false;
  String _testString =
      "To test: long press link and then copy and click from a non-browser "
      "app. Make sure this isn't being tested on iOS simulator and iOS xcode "
      "is properly setup. Look at firebase_dynamic_links/README.md for more "
      "details.";

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text("DynamicLink"),
          centerTitle: true,
          elevation: 0,
        ),
        body: Builder(builder: (BuildContext context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        // DynamicLinkHelper.createLink(false);
                        getDynamicLink();
                        _createDynamicLink(false);
                        // print("dynamic link long : " + DynamicLinkHelper.createLink(false).toString());
                      },
                      child: const Text('Get Long Link'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // DynamicLinkHelper.createLink(true);
                        _createDynamicLink(true);
                        // print("dynamic link short : " + DynamicLinkHelper.createLink(true).toString());
                      },
                      child: const Text('Get Short Link'),
                    ),
                  ],
                ),
                InkWell(
                  child: Text(
                    _linkMessage ?? '',
                    style: const TextStyle(color: Colors.blue),
                  ),
                  onTap: () async {
                    if (_linkMessage != null) {
                      await launch(_linkMessage);
                    }
                  },
                  onLongPress: () {
                    Clipboard.setData(ClipboardData(text: _linkMessage));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Copied Link!')),
                    );
                  },
                ),
                Text(_linkMessage == null ? '' : _testString)
              ],
            ),
          );
        }),
      ),
    );
  }

  /* this function get get your link, this function generally used in splash or you can use as per your requirement in project */
  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
          final Uri deepLink = dynamicLink?.link;

          if (deepLink != null) {
            print("deeplink : " + deepLink.toString());
          }
        }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
    await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      print("deeplink pending : " + deepLink.toString());
    }
  }

  /* this function create dynamic link */
  Future<void> _createDynamicLink(bool short) async {
    setState(() {
      _isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://flutterlearnapp.page.link',
      link: Uri.parse('https://flutterlearnapp.page.link/refer/?testing'),
      androidParameters: AndroidParameters(
        packageName: 'com.flutterlearnapp',
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.flutterlearnapp',
        minimumVersion: '0',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink = await parameters.buildShortLink();
      url = shortLink.shortUrl;
    } else {
      url = await parameters.buildUrl();
    }

    setState(() {
      _linkMessage = url.toString();
      _isCreatingLink = false;
      print("dynamic link :: " + _linkMessage);
    });
  }

  /* this function also create dynamic link using DynamicLinkHelper class */
  getDynamicLink() async {
    final link = await DynamicLinkHelper.createLink(false);
    final link1 = await DynamicLinkHelper.createLink(true);
    print("dynamic link long : " + link.toString());
    print("dynamic link short : " + link1.toString());
  }
}

// https://pub.dev/packages/firebase_dynamic_links
