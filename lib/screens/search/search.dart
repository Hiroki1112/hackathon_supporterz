import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:hackathon_supporterz/helper/post_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Search extends StatefulWidget {
  static String routeName = '/search';
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    String keyword = '';
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
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                'キーワード検索',
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
                              FaIcon(FontAwesomeIcons.terminal),
                              Text(snapshot.data![index].tag),
                            ],
                          ),
                        );
                      }),
                    );
                  }
                  return Text("");
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
