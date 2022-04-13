import 'package:intl/intl.dart';

var formatPatter = NumberFormat('###,###,###');

convertPriceFormat(price) {
  return formatPatter.format(double.parse(price)).toString();
}
