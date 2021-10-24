import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/helper/firebase_helper.dart';
import 'package:jiffy/models/post.dart';
import 'package:jiffy/screens/404/not_found.dart';
import 'package:jiffy/screens/post_detail/cards/body_card.dart';
import 'package:jiffy/screens/post_detail/cards/plan_text.dart';
import 'package:jiffy/screens/post_detail/cards/user_card.dart';
import 'package:jiffy/screens/post_detail/post_detail_tiles/post_edits_tile.dart';
import 'package:jiffy/screens/post_detail/title/title.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jiffy/util/config.dart';

class PostDetailTile extends StatefulWidget {
  const PostDetailTile({
    Key? key,
    required this.postId,
    this.userId,
  }) : super(
          key: key,
        );

  final String postId;
  final String? userId;
  @override
  _PostDetailTileState createState() => _PostDetailTileState();
}

class _PostDetailTileState extends State<PostDetailTile> {
  Post _post = Post();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: FutureBuilder(
          future: FirebaseHelper.getPost(
              userId: widget.userId ?? '', postId: widget.postId),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              //Post _post = Post();
              if (snapshot.data == CODE.postNotFound) {
                return NotFoundScreen();
              }
              _post = Post();
              _post.fromJson(snapshot.data!.data() ?? {});

              return ListView(
                children: [
                  DetailTitle(title: _post.title),
                  Center(
                    child: Container(
                      height: 100,
                      child: Image.network(
                        _post.headerImageURL,
                      ),
                    ),
                  ),
                  //PostEditsTile(userId: widget.userId ?? ''),
                  const SizedBox(height: 25),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '# 企画・構想',
                      style: Config.h3,
                    ),
                  ),
                  DetailPlanText(planeText: _post.planText),
                  const SizedBox(height: 25),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '# 本文',
                      style: Config.h3,
                    ),
                  ),
                  DetailBodyCard(bodyText: _post.bodyText),
                  const SizedBox(height: 25),
                  UserCard(userId: _post.userId),
                  const SizedBox(height: 60),
                ],
              );
            }

            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(),
                ],
              ),
            );
          }),
    );
  }
}
