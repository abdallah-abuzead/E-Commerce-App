import 'package:intl/intl.dart';

abstract class AppFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    final onlyDate = DateFormat('dd/MM/yyyy').format(date);
    final onlyTime = DateFormat('hh:mm').format(date);
    return '$onlyDate at $onlyTime';
  }

  static String formatPhoneNumber(String phoneNumber) {
    // Assuming a 10-digit US phone number format: (123) 456-7890
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)}-${phoneNumber.substring(7)}';
    }
    // If the phone number is not in the expected format, return it as is,
    // or add any other formatting logic as needed
    return phoneNumber;
  }

  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    return formatter.format(amount);
  }
}
