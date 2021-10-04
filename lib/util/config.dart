import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// デバイスの高さの取得、テキストのスタイルの設定のためのクラス
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
  static double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double deviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static TextStyle? h1(BuildContext context) => const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
      );
}
