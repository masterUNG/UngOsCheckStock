import 'package:flutter/material.dart';

class MyConstant {
  static Color primary = const Color.fromARGB(255, 37, 140, 223);
  static Color dark = const Color.fromARGB(255, 46, 6, 189);
  static Color light = const Color.fromARGB(255, 109, 202, 233);

  TextStyle h1Style() => TextStyle(
        fontSize: 36,
        color: dark,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );

  TextStyle h3SActiontyle() => const TextStyle(
        fontSize: 14,
        color: Color.fromARGB(255, 235, 66, 122),
        fontWeight: FontWeight.normal,
      );
}
