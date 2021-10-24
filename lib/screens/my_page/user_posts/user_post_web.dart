import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/helper/firebase_helper.dart';
import 'package:jiffy/models/simple_post.dart';
import 'package:jiffy/util/app_theme.dart';
import 'package:jiffy/widgets/tiles/post_tile.dart';

class UserPostWeb extends StatefulWidget {
  const UserPostWeb({
    Key? key,
    required this.uid,
  }) : super(key: key);
  final String uid;

  @override
  _UserPostWebState createState() => _UserPostWebState();
}

class _UserPostWebState extends State<UserPostWeb> {
  AsyncMemoizer<List<SimplePost>> memo = AsyncMemoizer();
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
            height: 10,
          ),
          FutureBuilder(
            //future: FirebaseHelper.getUserPosts(widget.uid),
            future: memo
                .runOnce(() async => FirebaseHelper.getUserPosts(widget.uid)),
            builder: (BuildContext context,
                AsyncSnapshot<List<SimplePost>> snapshot) {
              if (snapshot.hasError) {
                return const Text('データが上手く取得されませんでした');
              }

              if (snapshot.connectionState == ConnectionState.done) {
                // print(snapshot.data!.length);
                return Wrap(
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
