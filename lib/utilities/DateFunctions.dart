import 'package:intl/intl.dart';

class DateFunctions {

  /// this function gives you date in specific format.
  static String getFormattedDate(String date, String oldPattern, String newPattern) {
    return DateFormat(newPattern).format(DateFormat(oldPattern).parse(date));
  }

  /// this function gives you current date as per given pattern(For ex - dd/MM/yyyy, yyyy/MM/dd HH:mm:ss)
  static String getCurrentDate(String pattern) {
    return DateFormat(pattern).format(DateTime.now());
  }

  /// this function gives you millisecond from date.
  static dynamic getMillisFromDate(String date, String pattern) {
    var inputDate = DateFormat(pattern).parse(date);
    return inputDate.microsecond;
  }

  /// this function return specific date from entered date. For ex 12/17/2017 10:00:00 AM return Dec(month) pattern : "MMMM", "MMM"
  static dynamic getMonthNameFromDate(String date, String datePattern, String monthPattern) {
    return DateFormat(monthPattern).format(DateFormat(datePattern).parse(date));
  }

  /// this function gives you day name from given date. dayPattern - full name "EEEE", short name "EEE"
  static dynamic getDayNameFromDate(String date, String datePattern, String dayPattern) {
    return DateFormat(dayPattern).format(DateFormat(datePattern).parse(date));
  }

  /// this function gives you current month name - pattern for full name - "MMMM"
  static dynamic getCurrentMonthFullName() {
    return DateFormat.MMMM().format(DateTime.now());
  }

  /// this function gives you current month name - pattern for short name - "MMM"
  static dynamic getCurrentMonthShortName() {
    return DateFormat.MMM().format(DateTime.now());
  }

  /// this function gives you current time as per given pattern, pattern : HH:mm:ss, hh:mm a, etc...
  static dynamic  getCurrentTime(String pattern) {
    return DateFormat(pattern).format(DateTime.now());
  }

  /// this function get current day name - pattern for full name - "EEEE" for short name "EEE"
  static dynamic  getCurrentDayName(String pattern) {
    return DateFormat(pattern).format(DateTime.now());
  }

  /// this function provide you specific date.
  /// For ex. : specificDate ~ "17/12/1994"
  /// pattern : ex. "dd/MM/yyyy"
  /// nextPreviousDateNumber : nextSpecificDate(ex. 2) or previousSpecificDate(ex. -2)
  /// return : nextDate output - "19/12/1994", previousDate output - "15/12/1994"
  static dynamic  getNextDate(String date, String pattern, int nextDateNumber) {
    return DateFormat(pattern).format(DateFormat(pattern).parse(date).add(Duration(days: nextDateNumber)));
  }

  static dynamic  getPreviousDate(String date, String pattern, int previousDateNumber) {
    return DateFormat(pattern).format(DateFormat(pattern).parse(date).subtract(Duration(days: previousDateNumber)));
  }

  static dynamic  getCurrentYear() {
    return DateFormat.y().format(DateTime.now());
  }

  static dynamic  getCurrentM() {
    return DateFormat.M().format(DateTime.now());
  }

  static dynamic  getCurrentMD() {
    return DateFormat.Md().format(DateTime.now());
  }

  static dynamic  getCurrentMMDD() {
    return DateFormat.MMMd().format(DateTime.now());
  }

  static dynamic  getCurrentMMMD() {
    return DateFormat.MMMMd().format(DateTime.now());
  }

}