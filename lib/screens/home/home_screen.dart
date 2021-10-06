import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:hackathon_supporterz/widgets/tiles/post_tile.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  HomeScreen({
    Key? key,
  }) : super(key: key);

  final List<Widget> _widgets = List.generate(
    10,
    (index) => PostTile(
      simplePost: SimplePost(
        'JavaScript to Java tte niteruyone',
        'user hogehoge',
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: myAppBar(context),
      body: ListView(
        children: <Widget>[
          const Text(
            'trend',
            style: Config.h1,
          ),
          ..._widgets,
        ],
      ),
    );
  }
}
