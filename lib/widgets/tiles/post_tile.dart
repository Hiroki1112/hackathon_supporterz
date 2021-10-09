import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/models/user.dart';
import 'package:hackathon_supporterz/screens/post_detail/post_detail_trend.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';

class PostTile extends StatefulWidget {
  const PostTile({
    Key? key,
    required this.simplePost,
  }) : super(key: key);
  final SimplePost simplePost;

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  var db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var user = db.collection('api').doc('v1').collection('user');
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          PostDetailTrend.routeName,
          arguments: widget.simplePost.postId,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: AppTheme.darkShadow,
              spreadRadius: 1.0,
              blurRadius: 3.0,
              offset: const Offset(1, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              width: Config.deviceWidth(context) * 0.9,
              child: ListTile(
                leading: const Icon(
                  Icons.access_alarm_rounded,
                  size: 50,
                ),
                title: Column(
                  children: [
                    FutureBuilder(
                        future: user.get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // ユーザーデータを受け取る
                            MyUser _user = MyUser();
                            _user.fromJson(snapshot.data!.docs.first.data());

                            return Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 17.0),
                                  child: const Icon(
                                    Icons.people,
                                  ),
                                ),
                                Text(_user.useName),
                              ],
                            );
                          }
                          return const CircularProgressIndicator();
                        }),
                    Text(
                      widget.simplePost.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.simplePost.productTag,
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
              ),
            ),
            // ignore: prefer_const_constructors
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.thumb_up,
                ),
                const SizedBox(width: 5),
                Text(widget.simplePost.good.toString())
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SimplePost {
  final String title, userName, productTag, postId;
  final int good;

  SimplePost(
    this.title,
    this.userName,
    this.productTag,
    this.good,
    this.postId,
  );
}
