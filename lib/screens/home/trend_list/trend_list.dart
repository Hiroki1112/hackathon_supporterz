import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/models/post.dart';
import 'package:hackathon_supporterz/widgets/tiles/post_tile.dart';

class TrendList extends StatefulWidget {
  const TrendList({Key? key}) : super(key: key);

  @override
  _TrendListState createState() => _TrendListState();
}

class _TrendListState extends State<TrendList> {
  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;
    var trend = db.collection('api').doc('v1').collection('posts').limit(5);
    return FutureBuilder(
      future: trend.get(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('データの取得に失敗しました'),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          // データの取得ができたらリスト表示する
          //print(snapshot.data!.docs[0].data());

          return Column(
              children: List.generate(
            snapshot.data!.size,
            (index) {
              var _post = Post();
              _post.fromJson(snapshot.data!.docs[index].data());

              return PostTile(
                simplePost: SimplePost(
                  _post.title,
                  'usename',
                  '',
                  _post.goods,
                  _post.postId,
                ),
              );
            },
          ));
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
