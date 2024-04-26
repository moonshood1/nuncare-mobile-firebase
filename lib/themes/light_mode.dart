import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: const Color.fromARGB(255, 0, 186, 186),
    secondary: const Color.fromARGB(255, 0, 100, 100),
    tertiary: Colors.grey.shade400,
  ),
);
