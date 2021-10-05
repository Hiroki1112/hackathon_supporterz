import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/util/config.dart';

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
