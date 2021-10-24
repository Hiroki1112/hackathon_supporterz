import 'package:flutter/material.dart';
import 'package:jiffy/helper/app_helper.dart';
import 'package:jiffy/models/tag.dart';
import 'package:jiffy/screens/search/search_result/search_result_tag.dart';
import 'package:jiffy/util/app_theme.dart';

class TagCard extends StatelessWidget {
  const TagCard({
    Key? key,
    required this.tag,
  }) : super(key: key);
  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 160,
        maxWidth: 160,
      ),
      child: Container(
        margin: const EdgeInsets.all(5),
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
            Navigator.of(context)
                .pushNamed(SearchResultTag.routeName + tag.tag);
          },
          child: Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 80,
                  minHeight: 50,
                  maxWidth: 80,
                ),
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
      ),
    );
  }
}
