import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/screens/my_page/mypage_screen.dart';
import 'package:hackathon_supporterz/util/config.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Some text in Text widget',
              style: Config.h1,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  MyPageScreen.routeName,
                  arguments: MyPageScreenArgs('テキスト送信テスト'),
                );
              },
              child: const Text('画面遷移のテスト'),
            ),
          ],
        ),
      ),
    );
  }
}
