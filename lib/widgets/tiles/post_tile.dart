import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';

class PostTile extends StatelessWidget {
  const PostTile({
    Key? key,
    required this.simplePost,
  }) : super(key: key);
  final SimplePost simplePost;

  get padding => null;

  get margin => null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("hoge");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: AppTheme.darkShadow,
              spreadRadius: 1.0,
              blurRadius: 3.0,
              offset: const Offset(1, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: Config.deviceWidth(context) * 0.9,
              child: ListTile(
                leading: const Icon(
                  Icons.access_alarm_rounded,
                  size: 50,
                ),
                title: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: const Icon(
                            Icons.people,
                          ),
                        ),
                        Text(simplePost.userName),
                      ],
                    ),
                    Text(
                      simplePost.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      simplePost.productTag,
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
              ),
            ),
            // ignore: prefer_const_constructors
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.thumb_up,
                ),
                SizedBox(width: 5),
                Text("3")
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SimplePost {
  final String title, userName, productTag;

  SimplePost(this.title, this.userName, this.productTag);
}
