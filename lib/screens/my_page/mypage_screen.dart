import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/screens/404/not_found.dart';
import 'package:hackathon_supporterz/screens/my_page/profile/user_profile.dart';
import 'package:hackathon_supporterz/screens/my_page/user_posts/user_post_web.dart';
import 'package:hackathon_supporterz/screens/my_page/user_posts/user_posts.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/util/constants.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';

/// URLで渡された文字列をuidとしてfirebaseで検索する
class MyPageScreen extends StatefulWidget {
  const MyPageScreen({
    Key? key,
    this.userId,
  }) : super(key: key);
  final String? userId;

  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.userId == null || widget.userId == '') {
      debugPrint('MypageScreen class : userId is null or empty.');
      return Scaffold(
        appBar: myAppBar(context),
        body: const NotFoundScreen(),
      );
    }
    return Scaffold(
      appBar: myAppBar(context),
      body: LayoutBuilder(builder: (context, snapshot) {
        //if (Config.deviceWidth(context) > breakPoint) {
        if (kIsWeb) {
          return Center(
            child: Container(
              width: 720,
              child: ListView(
                // 無駄な読み込みを減らすためにキャッシュ領域を広げる
                cacheExtent: 250.0 * 3.0,
                children: [
                  UserProfile(userId: widget.userId ?? ''),
                  const Divider(
                    thickness: 3,
                  ),
                  UserPostWeb(uid: widget.userId ?? ''),
                ],
              ),
            ),
          );
        } else {
          return ListView(
            // 無駄な読み込みを減らすためにキャッシュ領域を広げる
            cacheExtent: 250.0 * 3.0,
            children: [
              UserProfile(userId: widget.userId ?? ''),
              const Divider(
                thickness: 3,
              ),
              UserPosts(uid: widget.userId ?? ''),
            ],
          );
        }
      }),
    );
  }
}
