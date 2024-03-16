import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'formatter.g.dart';

/// A provider that returns a function that returns the current date.
/// This makes it easy to mock the current date in tests.
@riverpod
DateTime Function() currentDateBuilder(CurrentDateBuilderRef ref) {
  return DateTime.now;
}

@riverpod
DateFormat formatDate(FormatDateRef ref, {String pattern = 'dd-MM-yyyy'}) {
  return DateFormat(pattern);
}

@riverpod
String formattedDate(
  FormattedDateRef ref,
  DateTime date, {
  String pattern = 'dd-MM-yyyy',
}) {
  return ref.watch(formatDateProvider(pattern: pattern)).format(date);
}

@riverpod
NumberFormat currencyFormatter(CurrencyFormatterRef ref, {String? locale}) {
  /// Currency formatter to be used in the app.
  /// * If `en_US` is hardcoded to ensure all prices show with a dollar sign ($)
  return NumberFormat.currency(locale: locale);
}

String dateStringFromDate(DateTime date) {
  final dateStr = DateFormat('hh:mm a').format(date);
  return dateStr;
}
