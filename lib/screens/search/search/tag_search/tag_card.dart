import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/helper/app_helper.dart';
import 'package:hackathon_supporterz/helper/post_helper.dart';
import 'package:hackathon_supporterz/screens/search/search/search.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';

class TagCard extends StatelessWidget {
  const TagCard({
    Key? key,
    required this.tag,
  }) : super(key: key);
  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkShadow,
            spreadRadius: 1.0,
            blurRadius: 3.0,
            offset: const Offset(1, 2),
          ),
        ],
        color: AppTheme.white,
      ),
      child: InkWell(
        onTap: () {
          String query = '?tag=' + tag.tag;
          Navigator.of(context).pushNamed(Search.routeName + query);
        },
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.15,
              width: MediaQuery.of(context).size.width * 0.3,
              child: Center(
                child: tag.url != ''
                    ? Image.network(
                        tag.url,
                      )
                    : Text(
                        AppHelper.oneEmoji(),
                        style: const TextStyle(
                          fontSize: 50,
                        ),
                      ),
              ),
            ),
            const Divider(thickness: 1.5),
            Text(
              tag.tag,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
