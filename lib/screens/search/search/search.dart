import 'package:flutter/material.dart';
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                'タグ検索',
                style: Config.h2,
              ),
            ),
            FutureBuilder(
                future: getReccomendedTags(),
                builder: (context, AsyncSnapshot<List<Tag>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // タグを返却する
                    return Wrap(
                      children: List.generate(snapshot.data!.length, (index) {
                        return Container(
                          margin: EdgeInsets.all(5),
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
                          child: Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.width * 0.2,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Center(
                                  child: snapshot.data![index].url != ''
                                      ? Image.network(
                                          snapshot.data![index].url,
                                        )
                                      : const Text(
                                          '🐣',
                                          style: TextStyle(fontSize: 50),
                                        ),
                                ),
                              ),
                              const Divider(thickness: 1.5),
                              Text(snapshot.data![index].tag),
                            ],
                          ),
                        );
                      }),
                    );
                  }
                  return const Text('');
                })
          ],
        ),
      ),
    );
  }

  Future<List<Tag>> getReccomendedTags() async {
    await Future.delayed(const Duration(seconds: 2));
    return targetList;
  }
}
