import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/screens/search/search/search.dart';
import 'package:hackathon_supporterz/screens/search/search_result/search_result_keyword.dart';
import 'package:hackathon_supporterz/screens/search/search_result/search_result_tag.dart';

class SearchRouter extends StatefulWidget {
  static String routeName = '/Search';
  const SearchRouter({
    Key? key,
    this.keyword,
  }) : super(key: key);
  final String? keyword;

  @override
  _SearchRouterState createState() => _SearchRouterState();
}

class _SearchRouterState extends State<SearchRouter> {
  @override
  Widget build(BuildContext context) {
    if (widget.keyword != null) {
      return SearchResultKeyword(keyword: widget.keyword);
    }

    return const Search();
  }
}
