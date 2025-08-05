// ignore_for_file: use_string_buffers

import 'dart:math';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

/// Converts a list of strings into a single string.
///
/// Takes a [list] of strings and concatenates them into a single string.
/// Optionally, a [withSpace] parameter can be provided to include spaces
/// between each element in the resulting string.
String listToStringConverter(List<String> list, {bool withSpace = false}) {
  var results = '';

  if (list.isNotEmpty) {
    for (var i = 0; i < list.length; i++) {
      if (i == 0) {
        results = list[i];
      } else {
        if (withSpace) {
          results = '$results, ${list[i]}';
        } else {
          results = '$results,${list[i]}';
        }
      }
    }
  }

  return results;
}

/// Generates a random string of specified [len]gth.
///
/// Uses a random number generator to create a string of alphanumeric
/// characters of the given length.
String generateRandomString(int len) {
  final r = Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final result =
      List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();

  return result.toUpperCase();
}

/// Generates a string representation of the current date and time.
///
/// Returns the current date and time formatted according to the
/// 'yyyy-MM-dd hh:mm:ss' pattern.
String generateCurrentDateTime() {
  final backendDateFormat = DateFormat('yyyy-MM-dd hh:mm:ss');

  final currentDate = DateTime.now();

  return backendDateFormat.format(currentDate);
}

/// Generates a UUID (Universally Unique Identifier).
///
/// Returns a string representing a UUID generated using the Uuid package.
String generateUUID() {
  return const Uuid().v4();
}

/// Formats a mobile number into the '+63' format for the Purego OMS API.
///
/// Takes a [mobileNumber] string and ensures it is formatted with the
/// country code '+63'.
String format63MobileNumber(String mobileNumber) {
  if (mobileNumber.substring(0, 1) == '+') {
    return mobileNumber;
  }
  final subMobileNumber = mobileNumber.substring(1, 11);
  return '+63$subMobileNumber';
}

/// Formats a mobile number into the '09' format for the Purego OMS API.
///
/// Takes a [paramMobileNumber] string and ensures it is formatted with the
/// country code '09'.
String format09MobileNumber(String paramMobileNumber) {
  var mobileNumber = paramMobileNumber;

  if (mobileNumber.substring(0, 1) == '+') {
    final subMobileNumber = mobileNumber.substring(3, 13);
    mobileNumber = '0$subMobileNumber';
  }
  return mobileNumber;
}
