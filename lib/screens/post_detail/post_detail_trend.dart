import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/models/post.dart';
import 'package:hackathon_supporterz/screens/post_detail/cards/body_card.dart';
import 'package:hackathon_supporterz/screens/post_detail/cards/user_card.dart';
import 'package:hackathon_supporterz/screens/post_detail/title/title.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PostDetailTrend extends StatefulWidget {
  static String routeName = '/detail';
  const PostDetailTrend({
    Key? key,
    required this.postId,
  }) : super(key: key);
  final String postId;

  @override
  _PostDetailTrendState createState() => _PostDetailTrendState();
}

class _PostDetailTrendState extends State<PostDetailTrend> {
  late final WebViewController _controller;
  var db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    debugPrint(widget.postId);
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: myAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: FutureBuilder(
            future: db
                .collection('api')
                .doc('v1')
                .collection('posts')
                .where('postId', isEqualTo: widget.postId)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Post _post = Post();
                _post.fromJson(snapshot.requireData.docs.first.data());

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      DetailTitle(title: _post.title),
                      DetailBodyCard(bodyText: _post.bodyText),
                      const UserCard(userId: 'userid'),
                    ],
                  ),
                );
              }

              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}
