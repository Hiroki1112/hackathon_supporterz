import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackathon_supporterz/screens/my_page/mypage_top.dart';
import 'package:hackathon_supporterz/screens/my_page/profile_edit.dart';
import 'package:hackathon_supporterz/screens/my_page/sns_buttons.dart';
import 'package:hackathon_supporterz/screens/post_screen/post_screen.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:hackathon_supporterz/widgets/tiles/post_tile.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPageScreen extends StatefulWidget {
  static String routeName = '/mypage';
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context,
      ),
      body: ListView(
        children: [
          MypageTop(
            pictureURL: '',
            username: 'yamada taro',
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              top: 5,
            ),
            child: Text(
              '自己紹介',
              textAlign: TextAlign.start,
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 25,
              top: 10,
              right: 15,
            ),
            child: Text(
              '最近flutterの勉強を始めました5歳児です。将来のキャリアプランに繋げたいです',
              textAlign: TextAlign.start,
              style: TextStyle(),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 23,
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ProfileEdit.routeName);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 5),
                child: Text(
                  'プロフィール編集',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SNSButtons(
            twitterLink: "https://twitter.com/taylorswift13",
            githubLink: "https://github.co.jp/",
          ),
          const Divider(
            thickness: 3,
          ),
          PostTile(
            simplePost: SimplePost(
              'JavaScript to Java tte niteruyone',
              'user hogehoge',
              '#Flutter',
            ),
          ),
          PostTile(
            simplePost: SimplePost(
              'JavaScript to Java tte niteruyone',
              'user hogehoge',
              '#Flutter',
            ),
          ),
          PostTile(
            simplePost: SimplePost(
              'JavaScript to Java tte niteruyone',
              'user hogehoge',
              '#Flutter',
            ),
          ),
        ],
      ),
    );
  }
}

// 引数が必要なクラスにはこのようなクラスを記述しておく。
// クラス名は直感的になるように、[対象のクラス]+Argsとする。
class MyPageScreenArgs {
  final String title;

  MyPageScreenArgs(this.title);
}
