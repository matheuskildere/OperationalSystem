import 'package:intl/intl.dart';

class DateParser {
  static const String dateFormat = 'yyyy-MM-dd H:mm';
  static const String brFormat = 'dd/MM/yyyy';
  static const String intervalFormat = 'dd/MM/yy | HH:mm';
  static const String intervalFormat2 = ' - HH:mm';

  static String getDateString(DateTime? date) {
    return date != null ? DateFormat(brFormat).format(date) : '';
  }

  static String getDateStringEn(DateTime? date) {
    return date != null ? DateFormat(dateFormat).format(date) : '';
  }

  static DateTime getDateTime(String? date) {
    return date != null
        ? DateFormat(dateFormat, 'pt_BR').parse(date)
        : DateTime(0, 0, 0);
  }

  static String getTimeInterval(
      {required DateTime start, required DateTime end}) {
    return '${DateFormat(intervalFormat).format(start)}${DateFormat(intervalFormat2).format(end)}';
  }

  static String getTimeOfService(
      {required DateTime start, required DateTime end}) {
    final minutes = end.difference(start).inMinutes.toString();
    return minutes;
  }
}
