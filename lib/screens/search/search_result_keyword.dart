import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/helper/firebase_helper.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';

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
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // 取得したデータを表示する
            print(snapshot.data);
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
