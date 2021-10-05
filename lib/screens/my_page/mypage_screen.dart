import 'package:flutter/material.dart';

class MyPageScreen extends StatelessWidget {
  static String routeName = '/mypage';
  const MyPageScreen({
    Key? key,
    this.title,
  }) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Page'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title!),
          ],
        ),
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
