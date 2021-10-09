import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/screens/home/trend_list/trend_list.dart';
import 'package:hackathon_supporterz/screens/post_detail/post_detail_idea.dart';
import 'package:hackathon_supporterz/screens/post_detail/post_detail_trend.dart';
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
      body: ListView(
        // 無駄な読み込みを減らすためにキャッシュ領域を広げる
        cacheExtent: 250.0 * 2.0,
        children: <Widget>[
          const Text(
            'trend',
            style: Config.h1,
          ),
          const TrendList(),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, PostDetailTrend.routeName);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                'トレンドを全て見る>',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
          const Text(
            'idea',
            style: Config.h1,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, PostDetailIdea.routeName);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                'アイデアを全て見る>',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
