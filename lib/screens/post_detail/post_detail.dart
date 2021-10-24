import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/helper/firebase_helper.dart';
import 'package:jiffy/models/post.dart';
import 'package:jiffy/screens/404/not_found.dart';
import 'package:jiffy/screens/post_detail/cards/body_card.dart';
import 'package:jiffy/screens/post_detail/cards/plan_text.dart';
import 'package:jiffy/screens/post_detail/cards/user_card.dart';
import 'package:jiffy/screens/post_detail/post_detail_tiles/post_detail_tile.dart';
import 'package:jiffy/screens/post_detail/post_detail_tiles/post_detail_web_tiles.dart';
import 'package:jiffy/screens/post_detail/title/title.dart';
import 'package:jiffy/util/app_theme.dart';
import 'package:jiffy/util/config.dart';
import 'package:jiffy/util/constants.dart';
import 'package:jiffy/widgets/appbar/my_appbar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PostDetail extends StatefulWidget {
  static String routeName = '/post/';
  const PostDetail({
    Key? key,
    required this.postId,
    this.userId,
  }) : super(key: key);
  final String postId;
  final String? userId;

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  Post _post = Post();

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    debugPrint(widget.postId);
    return Scaffold(
        backgroundColor: AppTheme.background,
        appBar: myAppBar(context),
        body: ListView(
          children: [
            LayoutBuilder(builder: (context, constraints) {
              if (kIsWeb) {
                return
                    // width: webWidth,
                    Center(
                  child: Container(
                    width: webWidth,
                    child: PostDetailWebTile(
                      postId: widget.postId,
                      userId: widget.userId,
                    ),
                  ),
                );
              } else {
                return PostDetailTile(
                  postId: widget.postId,
                  userId: widget.userId,
                );
              }
            }),
          ],
        ));
  }
}
