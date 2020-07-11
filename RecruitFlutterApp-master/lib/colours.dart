
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Colours {
static const Color app_main = Color(0xFFFC4E53);
static const Color blue_main = Color(0xFF37ABE3);
static const Color gray_8A8F8A= Color(0xFF8A8F8A);
static const Color gray_33A4AFA3= Color(0x33A4AFA3);
static Color slRandomColor({int r = 255, int g = 255, int b = 255, a = 255}) {
  if (r == 0 || g == 0 || b == 0) return Colors.black;
  if (a == 0) return Colors.white;
  return Color.fromARGB(
    a,
    r != 255 ? r : Random.secure().nextInt(r),
    g != 255 ? g : Random.secure().nextInt(g),
    b != 255 ? b : Random.secure().nextInt(b),
  );
}
}