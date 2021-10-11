import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/helper/firebase_helper.dart';
import 'package:hackathon_supporterz/models/post.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:hackathon_supporterz/widgets/tiles/post_tile.dart';

class SearchResultKeyword extends StatefulWidget {
  const SearchResultKeyword({
    Key? key,
    required this.keyword,
  }) : super(key: key);
  final String? keyword;

  @override
  _SearchResultKeywordState createState() => _SearchResultKeywordState();
}

class _SearchResultKeywordState extends State<SearchResultKeyword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: FutureBuilder(
        future: FirebaseHelper.getKeywordSearchResult(widget.keyword ?? ''),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // 取得したデータを表示する
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
              ),
            );
          }

          return Center(
            child: Column(
              children: const [
                CircularProgressIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }
}
