import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkHelper {
  static Future<String> createLink(bool short) async {
    String _linkMessage = "";

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

    _linkMessage = url.toString();

    return _linkMessage;
  }
}
