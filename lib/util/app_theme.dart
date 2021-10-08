import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

/// 各種カラー、themeをまとめたクラス
/// https://www.colorion.co/
class AppTheme {
  AppTheme._();

  // カラー系
  static Color background = HexColor('#F0F8FF');
  static Color darkShadow = Colors.black12;
  static Color lightShadow = HexColor('#E1E6EB');
  static Color purple = HexColor('#B0A0FC');

  static Color white = HexColor('#FEFEFF');
}
