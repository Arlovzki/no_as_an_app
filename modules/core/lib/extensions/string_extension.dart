/// The extension for string.
extension StringExtension on String {
  /// Formats the string into a name format similar to Google's account
  /// registration.
  ///
  /// ```dart
  /// '  eloN   DoGe '.nameFormat == 'elon doge'
  /// ```
  String get nameFormat {
    return trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  /// Removes the HTML tags from this string
  ///
  /// ```dart
  /// 'Hello<p>,</p> World!'.stripHtml == 'Hello, World!'
  /// ```
  String get stripHtml {
    return replaceAll(RegExp('<[^>]*>|&[^;]+;'), '');
  }

  /// Capitalized the first letter
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  /// Add enum converter here

  // ConnectDataStatus toConnectDataStatus() {
  //   switch (this) {
  //     case 'active':
  //       return ConnectDataStatus.active;
  //     case 'rejected':
  //       return ConnectDataStatus.rejected;
  //     default:
  //       return ConnectDataStatus.pendingApproval;
  //   }
  // }
}
