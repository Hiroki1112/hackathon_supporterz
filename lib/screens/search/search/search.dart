import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/helper/app_helper.dart';
import 'package:hackathon_supporterz/screens/search/search/tag_search/tag_search.dart';
import 'package:hackathon_supporterz/screens/search/search_result/search_result_keyword.dart';
import 'package:hackathon_supporterz/screens/search/search_result/search_result_tag.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:hackathon_supporterz/helper/post_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// クエリパラメターがない場合の遷移先
class Search extends StatefulWidget {
  static String routeName = '/search';
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String keyword = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'タイトル検索',
                style: Config.h2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'キーワードを入力してください。',
                      ),
                      onChanged: (String val) {
                        setState(() {
                          keyword = val;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      print(keyword);
                      Map<String, String> queryParams = {'keyword': keyword};
                      String queryString =
                          Uri(queryParameters: queryParams).query;
                      Navigator.of(context)
                          .pushNamed(Search.routeName + '?keyword=' + keyword);
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
            TagSearch(keyword: keyword),
          ],
        ),
      ),
    );
  }
}
