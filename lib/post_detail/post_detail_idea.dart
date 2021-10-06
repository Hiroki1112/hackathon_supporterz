import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:hackathon_supporterz/widgets/tiles/post_tile.dart';

class PostDetailIdea extends StatelessWidget {
  static String routeName = '/postdetailidea';
  PostDetailIdea({
    Key? key,
  }) : super(key: key);

  final List<Widget> _ideaWidgets = [
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
    // ignore: dead_code, dead_code
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: myAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: ListView(
          children: <Widget>[
            const Text(
              'Idea',
              style: Config.h1,
            ),
            ..._ideaWidgets,
          ],
        ),
      ),
    );
  }
}
