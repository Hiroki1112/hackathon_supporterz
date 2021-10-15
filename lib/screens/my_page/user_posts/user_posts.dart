import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/helper/firebase_helper.dart';
import 'package:hackathon_supporterz/models/simple_post.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/widgets/tiles/post_tile.dart';
import 'package:provider/src/provider.dart';

class UserPosts extends StatefulWidget {
  const UserPosts({
    Key? key,
    required this.uid,
  }) : super(key: key);
  final String uid;

  @override
  _UserPostsState createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
  @override
  Widget build(BuildContext context) {
    //final firebaseUser = context.watch<User?>();
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.background,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          FutureBuilder(
            future: FirebaseHelper.getUserPosts(widget.uid),
            builder: (BuildContext context,
                AsyncSnapshot<List<SimplePost>> snapshot) {
              if (snapshot.hasError) {
                return const Text('データが上手く取得されませんでした');
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: snapshot.data!
                      .map((post) => PostTile(simplePost: post))
                      .toList(),
                );
              }
              return Center(
                child: Column(
                  children: const [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
