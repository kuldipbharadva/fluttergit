import 'package:flutter/material.dart';
import 'package:flutter_learn_app/utilities/CommonFunctions.dart';

class Validations {

  static String emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static String alphaNumericRegex = r'^[a-zA-Z0-9]+$';

  /* this function check only blank validation */
  static bool isValidateBlank(
      BuildContext context,
      TextEditingController editingController,
      FocusNode focusNode,
      String msg) {
    String value = editingController.text.toString().trim();
    if (value.isEmpty) {
      focusNode.requestFocus();
      CommonFunctions.showSnackBar(context, msg, snackBarType: SnackBarType.FAILED);
      return false;
    }
    return true;
  }

  /* this function check min-max length validation */
  static bool isValidateLength(
      BuildContext context,
      TextEditingController editingController,
      FocusNode focusNode,
      String minMsg,
      String maxMsg,
      int min,
      int max) {
    String value = editingController.text.toString().trim();
    if (value.length < min) {
      focusNode.requestFocus();
      CommonFunctions.showSnackBar(context, minMsg, snackBarType: SnackBarType.FAILED);
      return false;
    }
    if (value.length > max) {
      focusNode.requestFocus();
      CommonFunctions.showSnackBar(context, maxMsg, snackBarType: SnackBarType.FAILED);
      return false;
    }
    return true;
  }

  /* this function check email validation using specific regex */
  static bool isValidateEmail(
      BuildContext context,
      TextEditingController editingController,
      FocusNode focusNode,
      String msg) {
    String value = editingController.text.toString().trim();
    bool emailValid = RegExp(emailRegex).hasMatch(value);
    if (!emailValid) {
      focusNode.requestFocus();
      CommonFunctions.showSnackBar(context, msg, snackBarType: SnackBarType.FAILED);
      return false;
    }
    return true;
  }

  /* this function check validation of password match */
  static bool isValidatePasswordMatch(
      BuildContext context,
      TextEditingController editingControllerPassword,
      TextEditingController editingControllerConfirmPassword,
      FocusNode focusNode,
      String msg) {
    String password = editingControllerPassword.text.toString().trim();
    String confirmPassword =
    editingControllerConfirmPassword.text.toString().trim();
    if (password != confirmPassword) {
      focusNode.requestFocus();
      CommonFunctions.showSnackBar(context, msg, snackBarType: SnackBarType.FAILED);
      return false;
    }
    return true;
  }

  /* this function used to check entered value not only (. ,) in decimal input field */
  static bool isValidateDecimalNumber(
      BuildContext context,
      TextEditingController editingController,
      FocusNode focusNode,
      String msg) {
    String value = editingController.text.toString().trim();
    if (value == "." || value == ",") {
      focusNode.requestFocus();
      CommonFunctions.showSnackBar(context, msg, snackBarType: SnackBarType.FAILED);
      return false;
    }
    return true;
  }

  /* this function check validation if enter value is greater than zero or not */
  static bool isValidateGreaterThanZero(
      BuildContext context,
      TextEditingController editingController,
      FocusNode focusNode,
      String msg) {
    String value = editingController.text.toString().trim();
    if (double.parse(value) <= 0) {
      focusNode.requestFocus();
      CommonFunctions.showSnackBar(context, msg, snackBarType: SnackBarType.FAILED);
      return false;
    }
    return true;
  }

}