import 'dart:math';

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
