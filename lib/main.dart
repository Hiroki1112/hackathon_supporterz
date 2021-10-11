import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/models/user.dart';
import 'package:hackathon_supporterz/provider/auth_provider.dart';
import 'package:hackathon_supporterz/routes.dart';
import 'package:hackathon_supporterz/screens/404/not_found.dart';
import 'package:hackathon_supporterz/screens/my_page/profile_edit.dart';
import 'package:hackathon_supporterz/screens/post_detail/post_detail_trend.dart';
import 'package:hackathon_supporterz/screens/search/search/search.dart';
import 'package:hackathon_supporterz/screens/search/search_result/search_result_keyword.dart';
import 'package:hackathon_supporterz/screens/search/search_result/search_result_tag.dart';
import 'package:hackathon_supporterz/screens/search/search_router.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/screens/home/home_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setPathUrlStrategy();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationProvider>().authState,
          initialData: null,
        ),
      ],
      child: MaterialApp(
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
          var paths = setting.name!.split('?');
          var path = paths[0];
          var queryParameters = {};
          if (paths.length > 1) {
            queryParameters = Uri.splitQueryString(paths[1]);
          }

          if (path == ProfileEdit.routeName) {
            final args = setting.arguments as MyUser;

            return MaterialPageRoute(
              builder: (BuildContext context) {
                return ProfileEdit(myUser: args);
              },
            );
          }

          if (path == PostDetailTrend.routeName) {
            final args = setting.arguments as String;

            return MaterialPageRoute(
              builder: (BuildContext context) {
                return PostDetailTrend(postId: args);
              },
            );
          }

          /// 検索時に使用するルーティング
          /// /serch => 検索ページ
          /// /search + keywordクエリ　=> keyword検索の結果を表示
          /// /search + tag => tag検索の結果をte
          if (path == Search.routeName) {
            /// エラーの原因となるので、!.は使用しない
            if (queryParameters.containsKey('keyword')) {
              return MaterialPageRoute(
                builder: (BuildContext context) {
                  return SearchRouter(keyword: queryParameters['keyword']);
                },
              );
            } else if (queryParameters.containsKey('tag')) {
              return MaterialPageRoute(
                builder: (BuildContext context) {
                  return SearchRouter(tag: queryParameters['tag']);
                },
              );
            }

            // クエリなしの場合
            return MaterialPageRoute(
              builder: (BuildContext context) {
                return const SearchRouter();
              },
            );
          }

          // return 404 page
          return MaterialPageRoute(
            builder: (BuildContext context) {
              return const NotFoundScreen();
            },
          );
        },
      ),
    );
  }
}
