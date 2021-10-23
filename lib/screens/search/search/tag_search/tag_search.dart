import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/helper/firebase_helper.dart';
import 'package:hackathon_supporterz/models/tag.dart';
import 'package:hackathon_supporterz/screens/search/search/tag_search/tag_card.dart';
import 'package:hackathon_supporterz/util/config.dart';

class TagSearch extends StatefulWidget {
  const TagSearch({
    Key? key,
    required this.keyword,
  }) : super(key: key);
  final String keyword;

  @override
  _TagSearchState createState() => _TagSearchState();
}

class _TagSearchState extends State<TagSearch> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(
            'タグ検索',
            style: Config.h2,
          ),
        ),
        FutureBuilder(
            future: FirebaseHelper.getTagListByKeyword(widget.keyword),
            builder: (context, AsyncSnapshot<List<Tag>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('タグが見つかりませんでした。'),
                  );
                }
                // タグを返却する
                return Center(
                  child: Wrap(
                    children: List.generate(snapshot.data!.length, (index) {
                      return TagCard(tag: snapshot.data![index]);
                    }),
                  ),
                );
              }

              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            })
      ],
    );
  }
}
