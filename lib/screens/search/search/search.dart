import 'package:flutter/material.dart';
import 'package:jiffy/screens/search/search/tag_search/tag_search.dart';
import 'package:jiffy/util/app_theme.dart';
import 'package:jiffy/util/config.dart';
import 'package:jiffy/util/constants.dart';
import 'package:jiffy/widgets/appbar/my_appbar.dart';

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
      backgroundColor: AppTheme.background,
      appBar: myAppBar(context),
      body: LayoutBuilder(builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.only(
              right: Config.deviceWidth(context) / 5,
              left: Config.deviceWidth(context) / 5),
          width: webWidth,
          child: SingleChildScrollView(
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
                          validator: (String? value) {
                            if (value != null) {
                              if (value.length < 2) {
                                return 'キーワードは2文字以上です';
                              }
                            }
                          },
                          onEditingComplete: () {
                            Navigator.of(context).pushNamed(
                                Search.routeName + '?keyword=' + keyword);
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              Search.routeName + '?keyword=' + keyword);
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
      }),
    );
  }
}
