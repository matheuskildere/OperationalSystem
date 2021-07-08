import 'package:intl/intl.dart';

class DateParser {
  static const String dateFormat = 'yyyy-MM-dd H:mm';
  static const String brFormat = 'dd/MM/yyyy';

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
}
