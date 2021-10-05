import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/screens/my_page/mypage_screen.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PostTile(
                  simplePost: SimplePost(
                    "JavaScript to Java tte niteruyone",
                    "user hogehoge",
                  ),
                ),
                PostTile(
                  simplePost: SimplePost(
                    "JavaScript to Java tte niteruyone",
                    "user hogehoge",
                  ),
                ),
              ],
            ),
          ],
        ),
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
      width: Config.deviceWidth(context) * 0.4,
      child: ListTile(
        leading: Icon(Icons.add),
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
