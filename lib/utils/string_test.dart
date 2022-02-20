import 'package:test/test.dart';

import './string.dart';

void main() {
  group('Slice', () {
    test('positive index', () {
      expect('abcdefg'.slice(1, 3), 'bc');
    });

    test('negative index', () {
      expect('abcdefg'.slice(-3, -1), 'ef');
    });

    test('negative index out of string length', () {
      expect('abc'.slice(-4), 'abc');
    });
  });
}
