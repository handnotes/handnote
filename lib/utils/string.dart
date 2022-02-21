import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

extension StringSlice on String {
  String slice(int start, [int? end]) {
    if (start < 0) {
      start = length + start;
    }
    end ??= length;
    if (end < 0) {
      end = length + end;
    }
    return substring(max(0, start), end);
  }
}

IconData? decodeIcon(String? string) {
  if (string == null) return null;

  try {
    return deserializeIcon(json.decode(string));
  } catch (e) {
    return null;
  }
}

String? encodeIcon(IconData? icon) {
  if (icon == null) return null;

  try {
    return json.encode(serializeIcon(icon, iconPack: IconPack.custom));
  } catch (e) {
    return null;
  }
}
