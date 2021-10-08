import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/models/post.dart';
import 'package:hackathon_supporterz/screens/post_screen/card/text_field_card.dart';
import 'package:hackathon_supporterz/screens/post_screen/popup/popup_setting.dart';
import 'package:hackathon_supporterz/screens/post_screen/card/preview_card.dart';
import 'package:hackathon_supporterz/screens/post_screen/popup/url_embedded.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:hackathon_supporterz/widgets/dialog/dialog.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  static String routeName = '/post';
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Post _post = Post();
  bool planIsPreview = false;
  bool bodyIsPreview = false;

  final TextEditingController _planTextController = TextEditingController();
  final TextEditingController _bodyTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    return Scaffold(
      appBar: myAppBar(context, title: 'Post Page'),
      backgroundColor: AppTheme.background,
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ListView(
            children: [
              TextFormField(
                  maxLines: 1,
                  maxLength: 40,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    fillColor: Colors.white,
                  ),
                  onChanged: (val) {
                    setState(() {
                      _post.setTitle = val;
                    });
                  },
                  validator: (String? val) {
                    if (val!.isEmpty) {
                      return 'タイトルを入力してください。';
                    }
                  }),
              const SizedBox(height: 10),
              _sectionTitle(
                '# 企画・構想',
                () {
                  setState(() {
                    planIsPreview = !planIsPreview;
                  });
                },
                _planTextController,
                planIsPreview,
              ),
              planIsPreview
                  ? PreviewCard(rawText: _post.planText)
                  : TextFieldCard(
                      controller: _planTextController,
                      onChanged: (String val) {
                        setState(() {
                          _post.setPlanText = val;
                        });
                      },
                      hintText: 'どのようなプロセスでこの案に辿り着いたのかを書いてみましょう。',
                    ),
              const SizedBox(height: 10),
              _sectionTitle(
                '# 本文',
                () {
                  setState(() {
                    bodyIsPreview = !bodyIsPreview;
                  });
                },
                _bodyTextController,
                bodyIsPreview,
              ),
              bodyIsPreview
                  ? PreviewCard(rawText: _post.bodyText)
                  : TextFieldCard(
                      controller: _bodyTextController,
                      onChanged: (String val) {
                        setState(() {
                          _post.setBodyText = val;
                        });
                      },
                      hintText: '制作物に関してMarkdown形式で書きましょう。',
                    ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var res = await yesNoDialog(
                            context, '確認', '記事を公開しますか？', '公開する', '戻る');
                        if (res ?? false) {
                          // 現時点ではダミーデータを一部セットする
                          _post.setTechTag = ['AWS', 'iOS', 'Go'];

                          // firebaseへ投稿する
                          var db = FirebaseFirestore.instance;
                          await db
                              .collection('api')
                              .doc('v1')
                              .collection('posts')
                              .add(
                                _post.toJson(firebaseUser!.uid),
                              );

                          await yesDialog(context, '確認', '投稿しました！');
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: const Text(
                      '投稿する',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, Function onEyePressed,
      TextEditingController controller, bool isPreview) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
      child: Row(
        children: [
          Text(
            title,
            style: Config.h3,
          ),
          const SizedBox(width: 15),
          IconButton(
            icon: isPreview
                ? const Icon(
                    Icons.skip_previous,
                  )
                : const Icon(
                    Icons.preview,
                    size: 20,
                  ),
            onPressed: () {
              onEyePressed();
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.photo_size_select_actual_outlined,
              size: 20,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.link,
              size: 20,
            ),
            onPressed: () async {
              var embed = await urlEmbedPopup(context);
              if (embed == null) {
                return;
              }
              // urlを取得したら、それを末尾に追加する
              final _newValue =
                  controller.text + '[${embed['title']}](${embed['url']})';
              controller.value = TextEditingValue(
                text: _newValue,
                selection: TextSelection.fromPosition(
                  TextPosition(offset: _newValue.length),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
