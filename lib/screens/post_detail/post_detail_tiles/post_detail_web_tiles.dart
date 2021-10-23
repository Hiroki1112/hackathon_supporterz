import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/helper/firebase_helper.dart';
import 'package:hackathon_supporterz/models/post.dart';
import 'package:hackathon_supporterz/screens/404/not_found.dart';
import 'package:hackathon_supporterz/screens/post_detail/cards/body_card.dart';
import 'package:hackathon_supporterz/screens/post_detail/cards/plan_text.dart';
import 'package:hackathon_supporterz/screens/post_detail/cards/user_card.dart';
import 'package:hackathon_supporterz/screens/post_detail/post_detail_tiles/post_edits_tile.dart';
import 'package:hackathon_supporterz/screens/post_detail/title/title.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetailWebTile extends StatefulWidget {
  const PostDetailWebTile({
    Key? key,
    required this.postId,
    this.userId,
  }) : super(key: key);
  final String postId;
  final String? userId;
  @override
  _PostDetailWebTileState createState() => _PostDetailWebTileState();
}

class _PostDetailWebTileState extends State<PostDetailWebTile> {
  Post _post = Post();
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DetailTitle(title: _post.title),
                      PostEditsTile(userId: widget.userId ?? ''),
                    ],
                  ),
                  const SizedBox(height: 30),
                  DetailPlanText(planeText: _post.planText),
                  const SizedBox(height: 30),
                  DetailBodyCard(bodyText: _post.bodyText),
                  const SizedBox(height: 30),
                  UserCard(userId: _post.userId),
                  const SizedBox(height: 30),
                ],
              ),
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
        });
  }
}
