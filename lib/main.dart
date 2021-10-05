import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/routes.dart';
import 'package:hackathon_supporterz/screens/404/not_found.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/screens/home/home_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'screens/my_page/mypage_screen.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Supporterz hackaython',
      theme: ThemeData(
        // Material Colorは以下の関数を用いて設定できる
        primarySwatch: Config.createMaterialColor(
          HexColor('#71D1D3'),
        ),
        backgroundColor: AppTheme.background,
        fontFamily: Config.themeFont,
      ),
      initialRoute: HomeScreen.routeName,
      routes: routes,
      onGenerateRoute: (RouteSettings setting) {
        // 引数つきの画面遷移の場合の例
        // 引数を格納するモデルを作成しておき、setting.argumentsで得られる値を
        // 作成したモデルにキャストして使用する。
        // 参考　：　https://flutter.dev/docs/cookbook/navigation/navigate-with-arguments
        // if (setting.name == MyPageScreen.routeName) {
        //   debugPrint(setting.name);
        //   final args = setting.arguments as MyPageScreenArgs;
        //   return MaterialPageRoute(
        //     // ここでsettingを渡さないと遷移した時にURLが遷移しない
        //     settings: setting,
        //     builder: (BuildContext context) {
        //       return MyPageScreen(
        //         title: args.title,
        //       );
        //     },
        //   );
        // }

        // return 404 page
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return const NotFoundScreen();
          },
        );
      },
    );
  }
}
