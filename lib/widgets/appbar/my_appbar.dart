import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:jiffy/models/user.dart';
import 'package:jiffy/provider/auth_provider.dart';
import 'package:jiffy/screens/calender/calender_screen.dart';
import 'package:jiffy/screens/home/home_screen.dart';
import 'package:jiffy/screens/post_screen/post_screen.dart';
import 'package:jiffy/screens/registration/registration_screen.dart';
import 'package:jiffy/screens/search/search/search.dart';
import 'package:jiffy/widgets/dialog/dialog.dart';
import 'package:jiffy/widgets/dialog/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// ログインボタンを表示する基本的なappBar
/// ログイン済みの時にはアイコンが表示される
AppBar myAppBar(BuildContext context, {String title = 'Jiffy'}) {
  final firebaseUser = context.watch<User?>();
  return AppBar(
    // モバイルの場合は表示(true)にする
    automaticallyImplyLeading: !kIsWeb,
    title: TextButton(
      onPressed: () {
        //print("home");
        Navigator.of(context).pushNamed(HomeScreen.routeName);
      },
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    ),

    actions: [
      IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Search.routeName);
        },
        icon: const Icon(Icons.search),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(CalenderScreen.routeName);
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
              'イベント日程',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
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
                    var db = FirebaseFirestore.instance;
                    var user = db
                        .collection('api')
                        .doc('v1')
                        .collection('users')
                        .where('firebaseId', isEqualTo: firebaseUser.uid);

                    var data = await user.get();
                    if (data.size > 0) {
                      if (data.docs.first.exists) {
                        // 存在しているユーザーの場合はマイページに遷移する
                        MyUser user = MyUser();
                        user.fromJson(data.docs.first.data());
                        Navigator.of(context).pushNamed(
                          '/' + user.userId,
                        );
                        return;
                      }
                    }

                    Navigator.of(context).pushNamed(
                      RegistrationScreen.routeName,
                    );
                  }

                  if (val == '記事の投稿') {
                    Navigator.of(context).pushNamed(PostScreen.routeName);
                  }
                  if (val == 'イベント日程') {
                    Navigator.of(context).pushNamed(CalenderScreen.routeName);
                  }
                  if (val == 'サインアウト') {
                    var res = await yesNoDialog(
                        context, '確認', 'サインアウトしますか？', 'サインアウト', '戻る');
                    if (res ?? false) {
                      context.read<AuthenticationProvider>().signOut();

                      //Navigator.pop(context);
                      // Navigator.of(context)
                      //     .restorablePushReplacementNamed(HomeScreen.routeName);
                    }
                  }
                },
                itemBuilder: (BuildContext context) {
                  return ['プロフィール', '記事の投稿', 'イベント日程', 'サインアウト']
                      .map((String s) {
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
