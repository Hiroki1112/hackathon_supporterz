import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/screens/home/home_screen.dart';
import 'package:hackathon_supporterz/screens/my_page/mypage_screen.dart';
import 'package:hackathon_supporterz/screens/post_screen/post_screen.dart';

/// routesに全てのページを集約して、クラス内で引数を取得することもできたが、
/// 引数が必要なウィジェット、不要なウィジェットが分かりにくくなるため
/// 今回は引数の必要ないページはroutesに、必要なウィジェットは
/// onGenerateRoute関数内に書くことにした。

/// 画面遷移のルーティングを管理するMap
/// 但し引数を渡す時はここには登録せず、onGenerateRoute内に
/// ページ遷移の処理を書く。
final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  MyPageScreen.routeName: (context) => const MyPageScreen(),
  PostScreen.routeName: (context) => const PostScreen(),
};
