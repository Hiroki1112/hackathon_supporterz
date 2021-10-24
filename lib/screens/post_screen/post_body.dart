import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/helper/firebase_helper.dart';
import 'package:jiffy/models/post.dart';
import 'package:jiffy/models/user.dart';
import 'package:jiffy/screens/post_screen/components/body_text_field.dart';
import 'package:jiffy/screens/post_screen/components/plan_text_field.dart';
import 'package:jiffy/screens/post_screen/components/post_inherited.dart';
import 'package:jiffy/screens/post_screen/components/title.dart';
import 'package:jiffy/screens/post_screen/components/tag_setting.dart';
import 'package:jiffy/widgets/dialog/dialog.dart';
import 'package:provider/provider.dart';
import 'components/popup/add_header_image.dart';

// Widgetを分割するにあたって状態管理のためにprovider等を使用する必要がある。
// しかしながらこの一部分の状態管理のために全体で値を読み込むことができるproviderを用意するのか？
// はたして綺麗な実装なのか？
// riverpodを使用すれば解決できるかもしれない？が、他の実装を優先させるために
// このような実装になっている。リファクタしたい。
class PostBody extends StatefulWidget {
  const PostBody({Key? key}) : super(key: key);

  @override
  _PostBodyState createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  final Post _post = Post();
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    return PostInherited(
      post: _post,
      child: ListView(
        children: [
          const SizedBox(height: 10),
          const InputTitle(),
          const TagSetting(),
          const SizedBox(height: 10),
          const PlanTextField(),
          const SizedBox(height: 10),
          const BodyTextField(),
          Center(
            child: Container(
              margin: const EdgeInsets.all(30),
              child: ElevatedButton(
                onPressed: () async {
                  // 必要情報を記入してもらう
                  // TODO: バリデーション

                  Uint8List? image = await addHeaderImage(context);

                  if (image == null) {
                    await yesDialog(context, 'エラー', '画像を設定してください');
                    return;
                  }

                  var res = await yesNoDialog(
                      context, '確認', '記事を公開しますか？', '公開する', '戻る');
                  if (res ?? false) {
                    // 自分のユーザーIDを取得する
                    var userInfo = await FirebaseHelper.getUserInfoByFirebaseId(
                        (firebaseUser?.uid ?? ''));

                    if (userInfo.size == 0) {
                      //
                      await yesDialog(context, 'ERROR', 'ユーザー情報が存在しません');
                      return;
                    }

                    MyUser _user = MyUser();
                    _user.fromJson(userInfo.docs.first.data());
                    // firebaseへ投稿する
                    print('hoge');

                    var url = await FirebaseHelper.saveAndGetURL(image);
                    if (url == CODE.failed) {
                      await yesDialog(context, 'エラー', '画像の登録に失敗しました');
                      return;
                    }
                    _post.setHeaderImageURL = url;

                    await FirebaseHelper.save2firebase(_post, _user.userId);

                    await yesDialog(context, '確認', '投稿しました！');
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    '投稿する',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50)
        ],
      ),
    );
  }
}
