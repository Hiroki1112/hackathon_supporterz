import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';

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
      ),
    ),
    PostTile(
      simplePost: SimplePost(
        'JavaScript to Java tte niteruyone',
        'user hogehoge',
      ),
    ),
    PostTile(
      simplePost: SimplePost(
        'JavaScript to Java tte niteruyone',
        'user hogehoge',
      ),
    ),
    PostTile(
      simplePost: SimplePost(
        'JavaScript to Java tte niteruyone',
        'user hogehoge',
      ),
    ),
    PostTile(
      simplePost: SimplePost(
        'JavaScript to Java tte niteruyone',
        'user hogehoge',
      ),
    ),
    PostTile(
      simplePost: SimplePost(
        'JavaScript to Java tte niteruyone',
        'user hogehoge',
      ),
    ),
    PostTile(
      simplePost: SimplePost(
        'JavaScript to Java tte niteruyone',
        'user hogehoge',
      ),
    ),
    PostTile(
      simplePost: SimplePost(
        'JavaScript to Java tte niteruyone',
        'user hogehoge',
      ),
    ),
    PostTile(
      simplePost: SimplePost(
        'JavaScript to Java tte niteruyone',
        'user hogehoge',
      ),
    ),
    PostTile(
      simplePost: SimplePost(
        'JavaScript to Java tte niteruyone',
        'user hogehoge',
      ),
    ),
    PostTile(
      simplePost: SimplePost(
        'JavaScript to Java tte niteruyone',
        'user hogehoge',
      ),
    ),
    PostTile(
      simplePost: SimplePost(
        'JavaScript to Java tte niteruyone',
        'user hogehoge',
      ),
    ),
    PostTile(
      simplePost: SimplePost(
        'JavaScript to Java tte niteruyone',
        'user hogehoge',
      ),
    ),
    PostTile(
      simplePost: SimplePost(
        'JavaScript to Java tte niteruyone',
        'user hogehoge',
      ),
    ),
    PostTile(
      simplePost: SimplePost(
        'JavaScript to Java tte niteruyone',
        'user hogehoge',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: myAppBar(),
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

class PostTile extends StatelessWidget {
  const PostTile({
    Key? key,
    required this.simplePost,
  }) : super(key: key);
  final SimplePost simplePost;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 5),
      width: Config.deviceWidth(context) * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: () {
          debugPrint('list tile tapped');
        },
        leading: const Icon(Icons.add),
        title: Column(
          children: [
            Text(
              simplePost.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(simplePost.userName)
          ],
        ),
      ),
    );
  }
}

class SimplePost {
  final String title, userName;

  SimplePost(this.title, this.userName);
}
