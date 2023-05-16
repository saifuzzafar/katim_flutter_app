import 'package:intl/intl.dart';

class AppUtils {
  AppUtils._();

  static String getFormattedDataAndTime(String input) {
    DateTime now = DateTime.parse(input);
    String formattedDate = DateFormat('E,d MMM yyyy HH:mm a').format(now);
    return formattedDate;
  }
}
