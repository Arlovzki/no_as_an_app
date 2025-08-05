import 'package:intl/intl.dart';

/// For frontend date format.
final DateFormat frontEndDateFormat = DateFormat('MM/dd/yyyy');

/// For backend date format.
final DateFormat backendDateFormat = DateFormat('yyyy-MM-dd');

/// Converts String date to frontend date format.
String convertToFrontEndDateFormat(String date) {
  final convertedDate = DateTime.parse(date);

  return frontEndDateFormat.format(convertedDate);
}

/// Converts String date to backend date format.
String convertToBackendDateFormat(String date) {
  final formattedDateList = date.split('/'); // [MM, DD, YYYY];
  // Assemble the splitted date to parse it.
  // YYYY-MM-DD
  final formattedDate =
      '${formattedDateList[2]}-${formattedDateList[0]}-${formattedDateList[1]}';

  final convertedDate = DateTime.parse(formattedDate);

  return backendDateFormat.format(convertedDate);
}
