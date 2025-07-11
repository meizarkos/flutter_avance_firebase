import 'package:intl/intl.dart';

extension DateStringExtensions on String? {
  String toEuroDate() {
    if(this == null) {
      return "No date";
    }
    try {
      final parsed = DateFormat('yyyy-MM-dd').parseStrict(this!);
      return DateFormat('dd/MM/yyyy').format(parsed);
    } catch (_) {
      return "No date";
    }
  }
}