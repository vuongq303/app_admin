import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Styles {
  Color get redOrange => const Color.fromARGB(255, 209, 120, 66);
  Color get gray => const Color.fromARGB(255, 130, 130, 130);
  Color get grayLight => const Color.fromARGB(255, 174, 174, 174);
  Color get black => const Color.fromARGB(255, 32, 31, 31);
  Color get bgColor => const Color.fromARGB(255, 43, 80, 160);
  Color get whColor => const Color.fromARGB(255, 255, 255, 255);
  Color get grColor => const Color.fromARGB(255, 169, 196, 108);
}

final stylesProvider = Provider<Styles>((ref) => Styles());
