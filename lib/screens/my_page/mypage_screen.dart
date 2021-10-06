import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/screens/my_page/profile_edit.dart';
import 'package:hackathon_supporterz/screens/post_screen/post_screen.dart';
import 'package:hackathon_supporterz/widgets/tiles/post_tile.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MyPageScreen extends StatelessWidget {
  static String routeName = '/mypage';
  const MyPageScreen({
    Key? key,
    //this.title,
  }) : super(key: key);
  //final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // モバイルの場合は表示(true)にする
        automaticallyImplyLeading: !kIsWeb,
        title: const Text('My Page1'),
        actions: [
          ElevatedButton(
            onPressed: () {
              // TODO: 投稿画面への遷移
              Navigator.pushNamed(context, PostScreen.routeName);
            },
            child: Text('Add new'),
          ),
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.people_outline,
                  size: 130,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'My Follow',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'userName',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              '自己紹介',
              textAlign: TextAlign.start,
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              '最近flutterの勉強を始めました5歳児です。将来のキャリアプランに繋げたいです',
              textAlign: TextAlign.start,
              style: TextStyle(),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 25,
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
