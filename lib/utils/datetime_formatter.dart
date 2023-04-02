import 'package:intl/intl.dart';

String getFormattedDate(DateTime dateTime) {
  return DateFormat('dd.MM.yyyy h:mma').format(dateTime);
}
