import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum Bank {
  gongshang,
  jianshe,
  nongye,
  zhongguo,
  zhaoshang,
  jiaotong,
  zhongxin,
  pufa,
  guangda,
  guangfa,
  minsheng,
  xingye,
  youchu,
  other,
}

class BankInfo {
  final Bank bank;
  final String name;
  final Widget icon;
  final Color color;

  const BankInfo(this.bank, this.name, this.icon, this.color);
}

Map<Bank, BankInfo> bankInfoMap = {
  Bank.gongshang:
      BankInfo(Bank.gongshang, '工商银行', SvgPicture.asset('assets/icons/bank/gongshang.svg'), Colors.red[300]!),
  Bank.jianshe: BankInfo(Bank.jianshe, '建设银行', SvgPicture.asset('assets/icons/bank/jianshe.svg'), Colors.blue[300]!),
  Bank.nongye: BankInfo(Bank.nongye, '农业银行', SvgPicture.asset('assets/icons/bank/nongye.svg'), Colors.green[300]!),
  Bank.zhongguo: BankInfo(Bank.zhongguo, '中国银行', SvgPicture.asset('assets/icons/bank/zhongguo.svg'), Colors.red[300]!),
  Bank.zhaoshang:
      BankInfo(Bank.zhaoshang, '招商银行', SvgPicture.asset('assets/icons/bank/zhaoshang.svg'), Colors.red[300]!),
  Bank.jiaotong: BankInfo(Bank.jiaotong, '交通银行', SvgPicture.asset('assets/icons/bank/jiaotong.svg'), Colors.blue[300]!),
  Bank.zhongxin: BankInfo(Bank.zhongxin, '中信银行', SvgPicture.asset('assets/icons/bank/zhongxin.svg'), Colors.red[300]!),
  Bank.pufa: BankInfo(Bank.pufa, '浦发银行', SvgPicture.asset('assets/icons/bank/pufa.svg'), Colors.blue[300]!),
  Bank.guangda: BankInfo(Bank.guangda, '光大银行', SvgPicture.asset('assets/icons/bank/guangda.svg'), Colors.purple[300]!),
  Bank.guangfa: BankInfo(Bank.guangfa, '广发银行', SvgPicture.asset('assets/icons/bank/guangfa.svg'), Colors.red[300]!),
  Bank.minsheng:
      BankInfo(Bank.minsheng, '民生银行', SvgPicture.asset('assets/icons/bank/minsheng.svg'), Colors.green[300]!),
  Bank.xingye: BankInfo(Bank.xingye, '兴业银行', SvgPicture.asset('assets/icons/bank/xingye.svg'), Colors.blue[300]!),
  Bank.youchu: BankInfo(Bank.youchu, '邮政储蓄银行', SvgPicture.asset('assets/icons/bank/youchu.svg'), Colors.green[300]!),
  Bank.other: BankInfo(Bank.other, '其他银行', const Icon(FontAwesome.bank, size: 20), Colors.orange[300]!),
};
