import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/models/simple_post.dart';
import 'package:hackathon_supporterz/models/user.dart';
import 'package:hackathon_supporterz/screens/post_detail/post_detail.dart';
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
    var user = db.collection('api').doc('v1').collection('users');

    return Center(
      child: Container(
        width: 320,
        margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(
                  widget.simplePost.userId + PostDetail.routeName,
                  arguments: widget.simplePost.postId,
                );
              },
              leading: Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/dummy1.jpg',
                    height: 75,
                    width: 75,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                      future: user.get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          // ユーザーデータを受け取る
                          MyUser _user = MyUser();
                          _user.fromJson(snapshot.data!.docs.first.data());

                          return Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 7.0,
                                ),
                                child: const Icon(
                                  Icons.people,
                                ),
                              ),
                              Text(
                                _user.useName,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          );
                        }
                        return const CircularProgressIndicator();
                      }),
                  Text(
                    widget.simplePost.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // タグを追加する
                  Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: widget.simplePost.techTag.map((tag) {
                          return Text('#' + tag + ', ');
                        }).toList(),
                      )),
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
          ],
        ),
      ),
    );
  }
}
