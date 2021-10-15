import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/screens/my_page/profile/user_profile.dart';
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
    return Scaffold(
      appBar: myAppBar(context),
      body: ListView(
        // 無駄な読み込みを減らすためにキャッシュ領域を広げる
        cacheExtent: 250.0 * 3.0,
        children: [
          UserProfile(userId: widget.userId ?? ''),
          const Divider(
            thickness: 3,
          ),
        ],
      ),
    );
  }
}
