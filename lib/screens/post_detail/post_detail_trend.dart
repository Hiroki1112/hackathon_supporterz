import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:hackathon_supporterz/widgets/tiles/post_tile.dart';

class PostDetailTrend extends StatelessWidget {
  static String routeName = '/postdetailtrend';
  PostDetailTrend({
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
              'All Articles',
              style: Config.h1,
            ),
            ..._widgets,
            ..._widgets,
            ..._widgets,
            ..._widgets,
            ..._widgets,
            ..._widgets,
            ..._widgets,
          ],
        ),
      ),
    );
  }
}
