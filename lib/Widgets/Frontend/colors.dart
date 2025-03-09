// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

const textColor = Color(0xFF090604);
const backgroundColor = Color(0xFFFDFCFA);
const primaryColor = Color(0xFFffbe98);
const primaryFgColor = Color(0xFFffbe98);
const secondaryColor = Color(0xFF99FFFE);
const secondaryFgColor = Color(0xFF99FFFE);
const accentColor = Color(0xFF93AAAA);
const accentFgColor = Color(0xFF414B4B);
const greyColor = Color.fromARGB(255, 216, 206, 200);
const errorColor = Color(0xFFFFA199);
  
const colorScheme = ColorScheme(
  brightness: Brightness.light,
  background: backgroundColor,
  onBackground: textColor,
  primary: primaryColor,
  onPrimary: primaryFgColor,
  secondary: secondaryColor,
  onSecondary: secondaryFgColor,
  tertiary: accentColor,
  onTertiary: accentFgColor,
  surface: backgroundColor,
  onSurface: textColor,
  error: errorColor,
  onError: errorColor,
);

