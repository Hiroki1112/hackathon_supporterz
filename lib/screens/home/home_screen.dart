import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/post_detail/post_detail_idea.dart';
import 'package:hackathon_supporterz/post_detail/post_detail_trend.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:hackathon_supporterz/widgets/tiles/post_tile.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  HomeScreen({
    Key? key,
  }) : super(key: key);

  final List<Widget> _widgets = [
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
    PostTile(
      simplePost: SimplePost(
        'JavaScript to Java tte niteruyone',
        'user hogehoge',
        '#Flutter',
      ),
    ),
  ];

  final List<Widget> _ideaWidgets = [
    PostTile(
      simplePost: SimplePost(
          'JavaScript to Java tte niteruyone', 'user hogehoge', '#Flutter'),
    ),
    PostTile(
      simplePost: SimplePost(
          'JavaScript to Java tte niteruyone', 'user hogehoge', '#Flutter'),
    ),
    PostTile(
      simplePost: SimplePost(
          'JavaScript to Java tte niteruyone', 'user hogehoge', '#Flutter'),
    ),
    PostTile(
      simplePost: SimplePost(
          'JavaScript to Java tte niteruyone', 'user hogehoge', '#Flutter'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: myAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: ListView(
          children: <Widget>[
            const Text(
              'trend',
              style: Config.h1,
            ),
            ..._widgets,
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
            ..._ideaWidgets,
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
      ),
    );
  }
}
