import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/models/simple_post.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/util/constants.dart';
import 'package:hackathon_supporterz/widgets/tiles/post_tile.dart';

class TrendList extends StatefulWidget {
  const TrendList({Key? key}) : super(key: key);

  @override
  _TrendListState createState() => _TrendListState();
}

class _TrendListState extends State<TrendList> {
  AsyncMemoizer<QuerySnapshot<Map<String, dynamic>>> memo = AsyncMemoizer();
  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;
    var trend = db.collection('api').doc('v1').collection('allPosts').limit(5);
    return FutureBuilder(
      future: memo.runOnce(() async => await trend.get()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('データの取得に失敗しました'),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          // データの取得ができたらリスト表示する
          if (Config.deviceWidth(context) > breakPoint) {
            return Container(
              //decoration: BoxDecoration(color: Colors.red),
              child: Wrap(
                direction: Axis.horizontal,
                children: List.generate(
                  snapshot.data!.size,
                  (index) {
                    SimplePost post =
                        SimplePost.fromJson(snapshot.data!.docs[index].data());

                    return Container(child: PostTile(simplePost: post));
                  },
                ),
              ),
            );
          } else {
            return Wrap(
              children: List.generate(
                snapshot.data!.size,
                (index) {
                  SimplePost post1;

                  post1 =
                      SimplePost.fromJson(snapshot.data!.docs[index].data());
                  return PostTile(simplePost: post1);
                },
              ),
            );
          }
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
