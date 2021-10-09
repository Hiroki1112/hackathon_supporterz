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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: myAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: ListView(
          children: const <Widget>[
            Text(
              'Idea',
              style: Config.h1,
            ),
          ],
        ),
      ),
    );
  }
}
