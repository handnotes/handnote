// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum Bank {
  OTHER,
  ICBC,
  CCB,
  ABC,
  CMBCHINA,
  BOC,
  CITIC,
  BOCOM,
  SPDB,
  CIB,
  GDB,
  HXB,
  CMBC,
}

Map<Bank, Color> bankColorMap = {
  Bank.OTHER: Colors.grey,
  Bank.ICBC: Colors.blue,
  Bank.CCB: Colors.red,
  Bank.ABC: Colors.orange,
  Bank.CMBCHINA: Colors.green,
  Bank.BOC: Colors.purple,
  Bank.CITIC: Colors.pink,
  Bank.BOCOM: Colors.brown,
  Bank.SPDB: Colors.cyan,
  Bank.CIB: Colors.indigo,
  Bank.GDB: Colors.lime,
  Bank.HXB: Colors.teal,
  Bank.CMBC: Colors.amber,
};
