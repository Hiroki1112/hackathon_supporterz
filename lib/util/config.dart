import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// デバイスサイズ、テキストのスタイル、その他テーマの設定のためのクラス
/// 異なるページ間でもスタイルを統一するために、可能な限り使用する。
///
/// {@tool snippet}
///
/// 以下の例では [Congig] クラスを使用してテキストにスタイルを与えている。
///
/// ```dart
///
/// Text(
///   'Some text in Text widget',
///   style: Config.h1(context),
/// ),
///
/// ```
/// {@end-tool}
///
class Config {
  Config._();

  // フォント系
  static String themeFont = 'NotoSansJP';

  // スクリーンサイズ等
  static double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double deviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  // テキストスタイル系
  static const TextStyle h1 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 21.0,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
  );

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    // ignore: avoid_function_literals_in_foreach_calls
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
