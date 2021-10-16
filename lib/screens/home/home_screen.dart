import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/helper/firebase_helper.dart';
import 'package:hackathon_supporterz/screens/home/trend_list/trend_list.dart';
import 'package:hackathon_supporterz/screens/post_detail/post_detail.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:hackathon_supporterz/widgets/tiles/post_tile.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: myAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          // 無駄な読み込みを減らすためにキャッシュ領域を広げる
          cacheExtent: 250.0 * 2.0,
          children: const <Widget>[
            Text(
              'trend',
              style: Config.h1,
            ),
            TrendList(),
            //_rignhtTextButton(() {}, context, 'トレンドを全て見る>'),
            Text(
              'idea',
              style: Config.h1,
            ),
            //_rignhtTextButton(() {}, context, 'アイデアを全て見る>'),
          ],
        ),
      ),
    );
  }

  _rignhtTextButton(Function onPressed, BuildContext context, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, PostDetail.routeName);
            },
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
