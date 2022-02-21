import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:handnote/widgets/svg_icon.dart';

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

  const BankInfo(this.bank, this.name, this.icon);
}

Map<Bank, BankInfo> bankInfoMap = {
  Bank.gongshang: BankInfo(Bank.gongshang, '工商银行', SvgIcon('bank/gongshang', color: Colors.red[300])),
  Bank.jianshe: BankInfo(Bank.jianshe, '建设银行', SvgIcon('bank/jianshe', color: Colors.blue[300])),
  Bank.nongye: BankInfo(Bank.nongye, '农业银行', SvgIcon('bank/nongye', color: Colors.green[300])),
  Bank.zhongguo: BankInfo(Bank.zhongguo, '中国银行', SvgIcon('bank/zhongguo', color: Colors.red[300])),
  Bank.zhaoshang: BankInfo(Bank.zhaoshang, '招商银行', SvgIcon('bank/zhaoshang', color: Colors.red[300])),
  Bank.jiaotong: BankInfo(Bank.jiaotong, '交通银行', SvgIcon('bank/jiaotong', color: Colors.blue[300])),
  Bank.zhongxin: BankInfo(Bank.zhongxin, '中信银行', SvgIcon('bank/zhongxin', color: Colors.red[300])),
  Bank.pufa: BankInfo(Bank.pufa, '浦发银行', SvgIcon('bank/pufa', color: Colors.blue[300])),
  Bank.guangda: BankInfo(Bank.guangda, '光大银行', SvgIcon('bank/guangda', color: Colors.purple[300])),
  Bank.guangfa: BankInfo(Bank.guangfa, '广发银行', SvgIcon('bank/guangfa', color: Colors.red[300])),
  Bank.minsheng: BankInfo(Bank.minsheng, '民生银行', SvgIcon('bank/minsheng', color: Colors.green[300])),
  Bank.xingye: BankInfo(Bank.xingye, '兴业银行', SvgIcon('bank/xingye', color: Colors.blue[300])),
  Bank.youchu: BankInfo(Bank.youchu, '邮政储蓄银行', SvgIcon('bank/youchu', color: Colors.green[300])),
  Bank.other: BankInfo(Bank.other, '其他银行', Icon(FontAwesome.bank, size: 20, color: Colors.orange[300])),
};
