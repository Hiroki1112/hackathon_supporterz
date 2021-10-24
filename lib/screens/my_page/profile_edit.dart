// ignore_for_file: unused_field

import 'package:async/async.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:jiffy/helper/firebase_helper.dart';
import 'package:jiffy/models/user.dart';
import 'package:jiffy/screens/404/not_found.dart';
import 'package:jiffy/util/app_theme.dart';
import 'package:jiffy/util/constants.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:validators/validators.dart';

class ProfileEdit extends StatefulWidget {
  static String routeName = '/settings/profile';
  const ProfileEdit({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  // ignore: prefer_final_fields
  MyUser _myuser = MyUser();
  final TextEditingController _controller = TextEditingController();
  AsyncMemoizer<QuerySnapshot<Map<String, dynamic>>> memo = AsyncMemoizer();
  bool isWebScreen = kIsWeb;
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        // モバイルの場合は表示(true)にする
        automaticallyImplyLeading: !kIsWeb,
        title: const Text('プロフィールを編集',
            style: TextStyle(
              color: Colors.white,
            )),
        actions: [
          IconButton(
            onPressed: () async {
              var db = FirebaseFirestore.instance;

              await db
                  .collection('api')
                  .doc('v1')
                  .collection('users')
                  .doc(_myuser.userId)
                  .set(
                    _myuser.toJson(),
                  );
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.check,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, snapshot) {
        return Center(
          child: Container(
            width: webWidth,
            child: FutureBuilder(
              future: memo.runOnce(() async =>
                  await FirebaseHelper.getUserInfoByFirebaseId(
                          firebaseUser!.uid)
                      as QuerySnapshot<Map<String, dynamic>>),

              //future: FirebaseHelper.getUserInfoByFirebaseId(firebaseUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasError) {
                  return const Text('データが上手く取得されませんでした');
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.docs.isEmpty) {
                    //if (snapshot.data!.data()!.isEmpty) {
                    debugPrint('UserProfile class : user not found');
                    return const NotFoundScreen();
                  }

                  _myuser.fromJson(snapshot.data!.docs.first.data());
                  //_myuser.fromJson(snapshot.data!.get('useName'));
                  //print(firebaseUser!.uid);
                  //print(snapshot.data);
                  return ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 25,
                            ),
                            width: 100,
                            height: 100,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                firebaseUser!.photoURL ?? '',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: const Text('名前'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: TextFormField(
                          //controller: _controller,
                          maxLines: 1,
                          maxLength: 25,
                          initialValue: _myuser.useName,
                          onChanged: (val) {
                            _myuser.setUserName = val;
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return '入力してください';
                            } else if (!isAlphanumeric(val)) {
                              return 'アルファベットで入力してください';
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: const Text('Twitter'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: TextFormField(
                          maxLines: 1,
                          maxLength: 25,
                          initialValue: _myuser.twitterLink,
                          onChanged: (val) {
                            _myuser.setTwitterLink = val;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: const Text('github'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: TextFormField(
                          maxLines: 1,
                          maxLength: 25,
                          initialValue: _myuser.githubAccount,
                          onChanged: (val) {
                            _myuser.setGithubAccount = val;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: const Text('自己紹介'),
                      ),
                      Container(
                        margin: const EdgeInsets.all(
                          15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.darkShadow,
                              spreadRadius: 1.0,
                              blurRadius: 3.0,
                              offset: const Offset(1, 2),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          maxLines: 10,
                          initialValue: _myuser.selfIntroduction,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppTheme.white,
                            hintText: '自己紹介',
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onChanged: (val) {
                            _myuser.setSelfIntroduction = val;
                          },
                        ),
                      ),
                      isWebScreen
                          ? Center(
                              child: Container(
                                margin: const EdgeInsets.all(30),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    var db = FirebaseFirestore.instance;
                                    await db
                                        .collection('api')
                                        .doc('v1')
                                        .collection('users')
                                        .doc(_myuser.userId)
                                        .set(
                                          _myuser.toJson(),
                                        );
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: const Text(
                                      '更新する',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
