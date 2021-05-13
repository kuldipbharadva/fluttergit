import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoaderView extends StatelessWidget {
  final Widget child;
  final bool showLoader;

  LoaderView({@required this.child, @required this.showLoader}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child:this.child,
      inAsyncCall: showLoader,
      // progressIndicator: getLoader(),
      progressIndicator: CircularProgressIndicator(),
    );
  }

  /* to use this need flutter_spinkit library */
/*
  Widget getLoader() {
    return SpinKitDoubleBounce(
      color: AppTheme.appButton,
      size: 50.0,
    );
  }
*/
}
