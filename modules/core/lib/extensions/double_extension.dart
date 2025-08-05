import 'package:intl/intl.dart';

/// Extension for double
extension DoubleExtension on double {
  /// Convert the double to peso format.
  ///
  /// 1.00 -> '₱1.00'
  String toPhpCurrency() => NumberFormat.currency(symbol: '₱').format(this);

  /// Convert the double to peso format without decimal.
  ///
  /// 1 -> '₱1'
  String toPhpCurrencyWithoutDecimal() =>
      NumberFormat.decimalPattern().format(this);

  /// Convert double to specific decimal.
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
