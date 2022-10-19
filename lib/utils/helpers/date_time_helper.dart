import 'package:intl/intl.dart';

/// Find the first date of the week which contains the provided [dateTime].
DateTime findFirstDateOfTheWeek({required DateTime dateTime}) {
  return dateTime.subtract(Duration(days: dateTime.weekday - 1));
}

/// Find last date of the week which contains provided [dateTime].
DateTime findLastDateOfTheWeek({required DateTime dateTime}) {
  return dateTime.add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
}

/// Format [date] to string using provided [format].
String formatDateToString({required DateTime date, required String format}) {
  DateFormat formatter = DateFormat(format);
  return formatter.format(date);
}
