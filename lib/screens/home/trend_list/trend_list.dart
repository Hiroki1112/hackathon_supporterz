import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/models/post.dart';
import 'package:hackathon_supporterz/models/simple_post.dart';
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

          return Column(
            children: List.generate(
              snapshot.data!.size,
              (index) {
                SimplePost post =
                    SimplePost.fromJson(snapshot.data!.docs[index].data());

                return PostTile(simplePost: post);
              },
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
