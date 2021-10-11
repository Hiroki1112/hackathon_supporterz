import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/helper/firebase_helper.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';

class SearchResultTag extends StatefulWidget {
  const SearchResultTag({
    Key? key,
    required this.tag,
  }) : super(key: key);
  final String? tag;

  @override
  _SearchResultTagState createState() => _SearchResultTagState();
}

class _SearchResultTagState extends State<SearchResultTag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: FutureBuilder(
        future: FirebaseHelper.getTagSearchResult(widget.tag ?? ''),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // 取得したデータを表示する

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
