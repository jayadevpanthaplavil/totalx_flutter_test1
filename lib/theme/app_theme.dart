import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:statusbarz/statusbarz.dart';

import '../constants/app_colors.dart';
import '../constants/fonts.gen.dart';

abstract class AppTheme {
  static ThemeData theme = ThemeData(
    useMaterial3: false,
    primarySwatch: generateMaterialColor(Palette.primary),
    fontFamily: FontFamily.montserrat,
    scaffoldBackgroundColor: Palette.scaffoldBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Palette.scaffoldBackgroundColor,
      iconTheme: IconThemeData(color: Colors.black),
    ),
  );

  static StatusbarzTheme kcStatusbarTheme = StatusbarzTheme(
    darkStatusBar: const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
    lightStatusBar: const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}
