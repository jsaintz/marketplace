import 'package:intl/intl.dart';

String formatCurrency(double currency) {
  String result;
  result = NumberFormat.simpleCurrency(locale: 'pt_BR', decimalDigits: 2).format(currency);
  return result;
}

sumOrderItem(totalOrderPrice) {
  num total = 0;
  for (num result in totalOrderPrice) {
    total += result;
  }
  return total;
}
