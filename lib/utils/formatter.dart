import 'package:intl/intl.dart';

final currencyYuanFormatter = NumberFormat.currency(
  locale: 'zh_CN',
  symbol: '¥',
  decimalDigits: 2,
);
final currencyDollarFormatter = NumberFormat.currency(
  locale: 'en_US',
  symbol: '\$',
  decimalDigits: 2,
);

final dateFormat = DateFormat('yyyy-MM-dd');
final dateFormatCn = DateFormat('yyyy年MM月dd日');
final monthDayFormatCn = DateFormat('MM月dd日');

final miniDateFormat = DateFormat('yyMMdd');
