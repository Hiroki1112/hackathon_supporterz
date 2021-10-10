import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/models/post.dart';
import 'package:hackathon_supporterz/models/user.dart';
import 'package:hackathon_supporterz/screens/my_page/mypage_top.dart';
import 'package:hackathon_supporterz/screens/my_page/profile_edit.dart';
import 'package:hackathon_supporterz/screens/my_page/sns_buttons.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:hackathon_supporterz/widgets/tiles/post_tile.dart';
import 'package:markdown/markdown.dart' as md;
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class MyPageScreen extends StatefulWidget {
  static String routeName = '/mypage';
  const MyPageScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  MyUser _myUser = MyUser();
  Post _post = Post();
  List<Post> posts = <Post>[];

  get leads => null;

  Future<void> fetchData(User? firebaseuser) async {
    // データ取得
    var db = FirebaseFirestore.instance;
    DocumentReference<Map<String, dynamic>> user = db
        .collection('api')
        .doc('v1')
        .collection('user')
        .doc(firebaseuser!.uid);

    DocumentSnapshot res = await user.get();

    //String userId = firebaseuser.uid;

    _myUser.fromJson(res.data() as Map<String, dynamic>);
  }

  Future<void> fetchMyPostData(String userId) async {
    var db = FirebaseFirestore.instance;

    QuerySnapshot<Map<String, dynamic>> post = await db
        .collection('api')
        .doc('v1')
        .collection('posts')
        .where('userId', isEqualTo: userId)
        .get();

    posts = await post.docs.map((p) {
      Post _post = Post();
      _post.fromJson(p.data());
      return _post;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    print(firebaseUser!.photoURL);

    return Scaffold(
      appBar: myAppBar(context),
      body: Container(
        child: ListView(
          // 無駄な読み込みを減らすためにキャッシュ領域を広げる
          cacheExtent: 250.0 * 3.0,
          children: [
            FutureBuilder(
              future: fetchData(firebaseUser),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MypageTop(
                        pictureURL: '',
                        username: _myUser.useName,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 5,
                        ),
                        child: const Text(
                          '自己紹介',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 25,
                          top: 10,
                          right: 15,
                        ),
                        child: Text(
                          _myUser.selfIntroduction,
                          textAlign: TextAlign.start,
                          style: const TextStyle(),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 23,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  await Navigator.pushNamed(
                                    context,
                                    ProfileEdit.routeName,
                                    arguments: _myUser,
                                  );
                                  await fetchData(firebaseUser);
                                  setState(() {});
                                },
                                child: const Text(
                                  'プロフィール編集',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SNSButtons(
                        twitterLink: _myUser.twitterLink,
                        githubLink: _myUser.githubAccount,
                      ),
                      const Divider(
                        thickness: 3,
                      ),
                    ],
                  );
                }

                return Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              },
            ),
            const Divider(
              thickness: 3,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.background,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  FutureBuilder(
                    future: fetchMyPostData(firebaseUser!.uid),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('データが上手く取得されませんでした');
                      }
                      int postLength = posts.length;

                      if (snapshot.connectionState == ConnectionState.done) {
                        //snapshot.connectionState == ConnectionState.done
                        return Column(
                          children: List.generate(
                            posts.length,
                            (index) {
                              var _post = Post();
                              _post = posts[index];

                              return PostTile(
                                simplePost: SimplePost(
                                  _post.title,
                                  'usename',
                                  '',
                                  _post.goods,
                                  _post.postId,
                                ),
                              );
                            },
                          ),
                        );
                      }
                      if (postLength <= 0) {
                        return Text('投稿がありません');
                      }
                      return Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
