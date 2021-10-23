import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hackathon_supporterz/helper/app_helper.dart';
import 'package:hackathon_supporterz/helper/firebase_helper.dart';
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
  AsyncMemoizer<DocumentSnapshot<Map<String, dynamic>>> memo = AsyncMemoizer();
  var db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          widget.simplePost.userId +
              PostDetail.routeName +
              widget.simplePost.postId,
        );
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 200,
          maxWidth: 450,
          minHeight: 160,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
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
                leading: Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.simplePost.headerImageUrl,
                      fit: BoxFit.fill,
                      errorBuilder: (c, o, s) {
                        return Text(
                          AppHelper.oneEmoji(),
                          style: const TextStyle(fontSize: 50),
                        );
                      },
                    ),
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                        future: memo.runOnce(() async =>
                            await FirebaseHelper.getUserInfo(
                                widget.simplePost.userId)),
                        builder: (BuildContext context,
                            AsyncSnapshot<
                                    DocumentSnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // ユーザーデータを受け取る
                            MyUser _user = MyUser();
                            _user.fromJson(snapshot.data?.data());

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
                          children: widget.simplePost.techTag.isNotEmpty
                              ? widget.simplePost.techTag.map((tag) {
                                  return Text('#' + tag + ', ');
                                }).toList()
                              : const [Text('# タグなし')],
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
      ),
    );
  }
}
