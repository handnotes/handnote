import 'package:nanoid/nanoid.dart';

const alphabet = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
const nanoidLength = 16;

String nanoid() {
  return customAlphabet(alphabet, nanoidLength);
}
