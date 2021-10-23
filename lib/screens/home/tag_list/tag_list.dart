import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/helper/firebase_helper.dart';
import 'package:hackathon_supporterz/models/tag.dart';
import 'package:hackathon_supporterz/screens/search/search/tag_search/tag_card.dart';

class TagList extends StatelessWidget {
  const TagList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseHelper.getTags(),
        builder: (context, AsyncSnapshot<List<Tag>?> snapshot) {
          if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            return Container();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              return Wrap(
                children:
                    snapshot.data?.map((tag) => TagCard(tag: tag)).toList() ??
                        [],
              );
            }
          }

          return Center(
            child: Column(
              children: const [
                CircularProgressIndicator(),
              ],
            ),
          );
        });
  }
}
