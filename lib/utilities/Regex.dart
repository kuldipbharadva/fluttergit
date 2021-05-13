class Regex {
  static String emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static String alphaNumericRegex = r'^[a-zA-Z0-9]+$';

  static final onlyCharacter = RegExp("[a-zA-Z ]");

  static final onlyDigits = RegExp("[0-9]");
}
