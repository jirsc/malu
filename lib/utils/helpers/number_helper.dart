import 'package:intl/intl.dart';

String numberToCompact(num number) {
  return NumberFormat.compact().format(number);
}
