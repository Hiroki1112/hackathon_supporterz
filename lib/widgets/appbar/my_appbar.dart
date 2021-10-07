import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hackathon_supporterz/provider/auth_provider.dart';
import 'package:hackathon_supporterz/screens/my_page/mypage_screen.dart';
import 'package:hackathon_supporterz/screens/post_screen/post_screen.dart';
import 'package:hackathon_supporterz/widgets/dialog/dialog.dart';
import 'package:hackathon_supporterz/widgets/dialog/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// ログインボタンを表示する基本的なappBar
/// ログイン済みの時にはアイコンが表示される
AppBar myAppBar(BuildContext context) {
  final firebaseUser = context.watch<User?>();
  return AppBar(
    // モバイルの場合は表示(true)にする
    automaticallyImplyLeading: !kIsWeb,
    title: const Text(
      'Supporterz',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.search),
      ),

      /// ユーザーのログイン状態に応じてウィジェットを変更する
      firebaseUser == null
          // ログインしていない場合
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () async {
                  await signIn(context);
                },
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    'ログイン',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton(
                /// 各選択肢を押したときの処理はここで定義する
                onSelected: (String val) async {
                  if (val == 'プロフィール') {
                    Navigator.of(context).pushNamed(MyPageScreen.routeName);
                  }
                  if (val == '記事の投稿') {
                    Navigator.of(context).pushNamed(PostScreen.routeName);
                  }
                  if (val == 'サインアウト') {
                    var res = await yesNoDialog(
                        context, '確認', 'サインアウトしますか？', 'サインアウト', '戻る');
                    if (res ?? false) {
                      context.read<AuthenticationProvider>().signOut();
                    }
                  }
                },
                itemBuilder: (BuildContext context) {
                  return ['プロフィール', '記事の投稿', 'サインアウト'].map((String s) {
                    return PopupMenuItem(
                      child: Text(s),
                      value: s,
                    );
                  }).toList();
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(firebaseUser.photoURL ?? ''),
                ),
              ),
            )
    ],
  );
}
