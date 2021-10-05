import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/screens/post_screen/post_screen.dart';
import 'package:hackathon_supporterz/widgets/tiles/post_tile.dart';

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
                Icon(Icons.pedal_bike),
                Column(
                  children: const [
                    Text('userName'),
                    Text('self introduce'),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 3,
          ),
          PostTile(
            simplePost: SimplePost(
              'JavaScript to Java tte niteruyone',
              'user hogehoge',
            ),
          ),
          PostTile(
            simplePost: SimplePost(
              'JavaScript to Java tte niteruyone',
              'user hogehoge',
            ),
          ),
          PostTile(
            simplePost: SimplePost(
              'JavaScript to Java tte niteruyone',
              'user hogehoge',
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
