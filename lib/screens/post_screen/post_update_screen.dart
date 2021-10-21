import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/helper/post_helper.dart';
import 'package:hackathon_supporterz/models/post.dart';
import 'package:hackathon_supporterz/models/simple_post.dart';
import 'package:hackathon_supporterz/screens/post_screen/components/card/text_field_card.dart';
import 'package:hackathon_supporterz/screens/post_screen/components/card/preview_card.dart';
import 'package:hackathon_supporterz/screens/post_screen/components/popup/url_embedded.dart';
import 'package:hackathon_supporterz/screens/post_screen/components/tag_setting.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:hackathon_supporterz/widgets/dialog/dialog.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class PostUpdateScreen extends StatefulWidget {
  static String routeName = '/postupdate';
  const PostUpdateScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  final SimplePost post;
  @override
  _PostUpdateScreenState createState() => _PostUpdateScreenState();
}

class _PostUpdateScreenState extends State<PostUpdateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Post _post = Post();
  bool planIsPreview = false;
  bool bodyIsPreview = false;

  final TextEditingController _planTextController = TextEditingController();
  final TextEditingController _bodyTextController = TextEditingController();
  List<Tag> tags = [];

  bool isPostGetDone = false;
  Future<void> getPostData() async {
    if (isPostGetDone) {
      return;
    }
    Post post =
        Post(); //await FirebaseHelper.getPostByPostId(widget.post.postId);//getPost(widget.post.postId);

    _post = post;
    _bodyTextController.text = _post.bodyText;
    _planTextController.text = _post.planText;
    isPostGetDone = true;
  }

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
          child: FutureBuilder(
            future: getPostData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListView(
                    children: [
                      TextFormField(
                        maxLines: 1,
                        maxLength: 40,
                        initialValue: _post.title,
                        decoration: const InputDecoration(
                          //hintText: 'Title',
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
                        },
                      ),
                      const SizedBox(height: 10),
                      TagSetting(),
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
                                // 必要情報を記入してもらう

                                var res = await yesNoDialog(
                                    context, '確認', '記事を公開しますか？', '公開する', '戻る');
                                if (res ?? false) {
                                  // 現時点ではダミーデータを一部セットする
                                  _post.setTechTag = ['AWS', 'iOS', 'Go'];
                                  _post.setUserId = firebaseUser!.uid;

                                  // firebaseへ投稿する
                                  var db = FirebaseFirestore.instance;
                                  QuerySnapshot<Map<String, dynamic>>
                                      updatePost = await db
                                          .collection('api')
                                          .doc('v1')
                                          .collection('posts')
                                          .where('postId',
                                              isEqualTo: _post.postId)
                                          .get();
                                  // .add(
                                  //     _post.toJson(firebaseUser.uid),
                                  //   );
                                  await db
                                      .collection('api')
                                      .doc('v1')
                                      .collection('posts')
                                      .doc(updatePost.docs.first.id)
                                      .update(_post.toJson(firebaseUser.uid));
                                  //db.collection('api').doc('v1').collection('posts'.toUpperCase())
                                  //if(snapshot.connectionState == ConnectionState.done)

                                  await yesDialog(context, '確認', '投稿しました！');
                                  Navigator.pop(context);
                                }
                              }
                            },
                            child: const Text(
                              '更新する',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50)
                    ],
                  ),
                );
              }
              return const Text('');
            },
          )),
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
            onPressed: () async {
              String result = await _upload();

              // 取得できた場合は文章中に埋め込む
              final _newValue = controller.text + '![$result]($result)';
              controller.value = TextEditingValue(
                text: _newValue,
                selection: TextSelection.fromPosition(
                  TextPosition(offset: _newValue.length),
                ),
              );
            },
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

  Future<String> _upload() async {
    // ファイルを選択する
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);

    if (result != null) {
      // fileを選択する
      File file = File(result.files.single.path!);

      try {
        var task = await firebase_storage.FirebaseStorage.instance
            .ref('postImage/hgoe.png')
            .putFile(file);

        return task.ref.fullPath;
      } on firebase_storage.FirebaseException catch (e) {
        debugPrint(e.message);
      }
    }
    return 'failed';
  }
}
