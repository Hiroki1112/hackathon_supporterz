import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/helper/firebase_helper.dart';
import 'package:jiffy/models/simple_post.dart';
import 'package:jiffy/screens/404/not_found.dart';
import 'package:jiffy/util/app_theme.dart';
import 'package:jiffy/util/config.dart';
import 'package:jiffy/widgets/appbar/my_appbar.dart';
import 'package:jiffy/widgets/tiles/post_tile.dart';

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
    if (widget.keyword == '') {
      return Scaffold(
        backgroundColor: AppTheme.background,
        appBar: myAppBar(context),
        body: NotFoundScreen(),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: myAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (widget.keyword ?? '') + 'での検索結果',
                  style: Config.h2,
                ),
                FutureBuilder(
                  future: FirebaseHelper.getKeywordSearchResult(
                      widget.keyword ?? ''),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // 取得したデータを表示する
                      if (snapshot.data!.size == 0) {
                        return Center(
                          child: Column(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text('記事が見つかりませんでした。'),
                              ),
                            ],
                          ),
                        );
                      }
                      return Column(
                        children: List.generate(
                          snapshot.data!.size,
                          (index) {
                            SimplePost post = SimplePost.fromJson(
                                snapshot.data!.docs[index].data());

                            return PostTile(simplePost: post);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
