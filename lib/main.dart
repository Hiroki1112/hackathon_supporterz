import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/models/user.dart';
import 'package:jiffy/provider/auth_provider.dart';
import 'package:jiffy/screens/404/not_found.dart';
import 'package:jiffy/screens/calender/calender_screen.dart';
import 'package:jiffy/screens/calender/event_register_screen/event_register.dart';
import 'package:jiffy/screens/my_page/mypage_screen.dart';
import 'package:jiffy/screens/my_page/profile_edit.dart';
import 'package:jiffy/screens/post_detail/post_detail.dart';
import 'package:jiffy/screens/post_screen/post_screen.dart';
import 'package:jiffy/screens/registration/registration_screen.dart';
import 'package:jiffy/screens/search/search/search.dart';
import 'package:jiffy/screens/search/search_result/search_result_tag.dart';
import 'package:jiffy/screens/search/search_router.dart';
import 'package:jiffy/util/app_theme.dart';
import 'package:jiffy/util/config.dart';
import 'package:jiffy/screens/home/home_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

bool USE_FIRESTORE_EMULATOR = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setPathUrlStrategy();
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }
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
          // Material Color?????????????????????????????????????????????
          primarySwatch: Config.createMaterialColor(
            HexColor('#71D1D3'),
          ),
          backgroundColor: AppTheme.background,
          fontFamily: Config.themeFont,
        ),
        onGenerateRoute: (RouteSettings setting) {
          // ??????????????????????????????????????????
          // ??????????????????????????????????????????????????????setting.arguments?????????????????????
          // ?????????????????????????????????????????????????????????
          // ???????????????https://flutter.dev/docs/cookbook/navigation/navigate-with-arguments
          var paths = setting.name!.split('?');
          var path = paths[0];
          var queryParameters = {};
          if (paths.length > 1) {
            queryParameters = Uri.splitQueryString(paths[1]);
          }

          if (path == HomeScreen.routeName) {
            return MaterialPageRoute(
              settings: setting,
              builder: (BuildContext context) {
                return const HomeScreen();
              },
            );
          }

          if (path == CalenderScreen.routeName) {
            return MaterialPageRoute(
              settings: setting,
              builder: (BuildContext context) {
                return const CalenderScreen();
              },
            );
          }

          /// /settings/profile
          if (path == ProfileEdit.routeName) {
            return MaterialPageRoute(
              settings: setting,
              builder: (BuildContext context) {
                return const ProfileEdit();
              },
            );
          }

          if (path == EventRegister.routeName) {
            return MaterialPageRoute(
              settings: setting,
              builder: (BuildContext context) {
                return const EventRegister();
              },
            );
          }

          // drafts/new
          if (path == PostScreen.routeName) {
            return MaterialPageRoute(
              settings: setting,
              builder: (BuildContext context) {
                return const PostScreen();
              },
            );
          }

          /// post??????????????????????????????????????????
          /// :uid/post/:id ????????????id????????????????????????????????????

          if (path.contains('/post')) {
            if (path.split('/').length > 2) {
              if (path.split('/')[1] == 'post') {
                String userId = path.split('/')[0];
                String postId = path.split('/')[2];

                return MaterialPageRoute(
                  settings: setting,
                  builder: (BuildContext context) {
                    return PostDetail(
                      postId: postId,
                      userId: userId,
                    );
                  },
                );
              }
            }
          }

          /// /tag/:tag
          if (path.startsWith(SearchResultTag.routeName)) {
            // ??????????????????URL??????????????????

            String tag = path.split('/')[2];
            return MaterialPageRoute(
              settings: setting,
              builder: (BuildContext context) {
                return SearchResultTag(tag: tag);
              },
            );
          }

          /// ??????????????????????????????????????????
          /// /serch => ???????????????
          /// /search + keyword????????????=> keyword????????????????????????
          /// /search + tag => tag??????????????????te
          if (path == Search.routeName) {
            /// ????????????????????????????????????!.??????????????????
            if (queryParameters.containsKey('keyword')) {
              return MaterialPageRoute(
                settings: setting,
                builder: (BuildContext context) {
                  return SearchRouter(keyword: queryParameters['keyword']);
                },
              );
            }

            // ????????????????????????
            return MaterialPageRoute(
              settings: setting,
              builder: (BuildContext context) {
                return const SearchRouter();
              },
            );
          }

          // /registration
          if (path == RegistrationScreen.routeName) {
            return MaterialPageRoute(
              settings: setting,
              builder: (BuildContext context) {
                return const RegistrationScreen();
              },
            );
          }

          /// /:uid??????????????????????????????????????????
          String uid = path.split('/')[1];
          if (path.split('/').length < 3) {
            return MaterialPageRoute(
              settings: setting,
              builder: (BuildContext context) {
                return MyPageScreen(userId: uid);
              },
            );
          }

          return MaterialPageRoute(
            settings: setting,
            builder: (BuildContext context) {
              return const NotFoundScreen();
            },
          );

          // 404????????????????????????????????????????????????????????????????????????????????????
        },
      ),
    );
  }
}
