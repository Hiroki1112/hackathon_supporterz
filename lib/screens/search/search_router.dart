import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/screens/search/search.dart';
import 'package:hackathon_supporterz/screens/search/search_result_keyword.dart';
import 'package:hackathon_supporterz/screens/search/search_result_tag.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:hackathon_supporterz/helper/post_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchRouter extends StatefulWidget {
  static String routeName = '/Search';
  const SearchRouter({
    Key? key,
    this.keyword,
    this.tag,
  }) : super(key: key);
  final String? keyword;
  final String? tag;

  @override
  _SearchRouterState createState() => _SearchRouterState();
}

class _SearchRouterState extends State<SearchRouter> {
  @override
  Widget build(BuildContext context) {
    if (widget.keyword != null) {
      return SearchResultKeyword(keyword: widget.keyword);
    } else if (widget.tag != null) {
      return SearchResultTag(tag: widget.tag);
    }

    return Search();
  }
}
