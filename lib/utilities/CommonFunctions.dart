import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CommonFunctions {
  /* this function show toast msg */
  static showToast(BuildContext context, String msg, {int gravity}) {
    Toast.show(msg, context,
        duration: Toast.LENGTH_SHORT,
        gravity: gravity != null ? gravity : Toast.BOTTOM);
  }

  /* this function show default snackbar */
  static showDefaultSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  /* this function show top snackbar based on type */
  static showTopSnackBarMsg(BuildContext context, String msg,
      {SnackBarType snackBarType}) {
    switch (snackBarType) {
      case SnackBarType.SUCCESS:
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message: msg,
            backgroundColor: Colors.green[600],
            textStyle: TextStyle(color: Colors.white, fontSize: 18),
          ),
        );
        break;
      case SnackBarType.FAILED:
        showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: msg,
              icon: Container(),
              backgroundColor: Colors.redAccent,
              textStyle: TextStyle(color: Colors.white, fontSize: 18),
            ),
            showOutAnimationDuration: Duration(seconds: 0),
            hideOutAnimationDuration: Duration(seconds: 0),
            additionalTopPadding: 0,
            displayDuration: Duration(seconds: 2));
        break;
      case SnackBarType.INFO:
        showTopSnackBar(
          context,
          CustomSnackBar.info(
            message: msg,
            textStyle: TextStyle(fontSize: 18),
          ),
        );
        break;
    }
  }

  /* this function show snackbar */
  static showSnackBar(BuildContext context, String msg,
      {SnackBarType snackBarType}) {
    showTopSnackBarMsg(context, msg,
        snackBarType: snackBarType != null ? snackBarType : SnackBarType.INFO);
  }

  /* this function clear cursor focus */
  static void clearFocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  /* this function change input field focus */
  static void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}

enum SnackBarType { SUCCESS, FAILED, INFO }
