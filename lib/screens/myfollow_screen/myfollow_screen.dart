import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/main.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:hackathon_supporterz/widgets/tiles/post_tile.dart';

class MyfollowScreen extends StatefulWidget {
  const MyfollowScreen({Key? key}) : super(key: key);

  @override
  _MyfollowScreenState createState() => _MyfollowScreenState();
}

class _MyfollowScreenState extends State<MyfollowScreen> {
  var contexxt;

  final List<Widget> _widgets = List.generate(
    //follower_tileを作ってposttileと同様にする
    10,
    (index) => PostTile(
      simplePost: SimplePost(
        'JavaScript to Java tte niteruyone',
        'user hogehoge',
        '#Flutter',
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(contexxt),
      body: ListView(
        children: <Widget>[
          const Text(
            'すべてのフォロワー',
            style: Config.h1,
          ),
          ..._widgets,
          const Text(
            'idea',
            style: Config.h1,
          ),
        ],
      ),
    );
  }
}
