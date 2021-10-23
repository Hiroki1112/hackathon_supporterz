import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/screens/home/tag_list/tag_list.dart';
import 'package:hackathon_supporterz/screens/home/trend_list/trend_list.dart';
import 'package:hackathon_supporterz/util/config.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: 15),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '最近の投稿',
            style: Config.h2,
          ),
        ),
        TrendList(),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'おすすめのタグ',
            style: Config.h2,
          ),
        ),
        TagList(),
      ],
    );
  }
}
