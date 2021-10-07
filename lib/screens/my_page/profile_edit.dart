// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/models/post.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hackathon_supporterz/models/user.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:markdown/markdown.dart' as markdown;
import 'package:provider/src/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'mypage_screen.dart';

class ProfileEdit extends StatefulWidget {
  static String routeName = '/profileedit';
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  // ignore: prefer_final_fields
  MyUser _myuser = MyUser();
  final TextEditingController _controller = TextEditingController();

  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        // モバイルの場合は表示(true)にする
        automaticallyImplyLeading: !kIsWeb,
        title: Text("プロフィールを編集",
            style: TextStyle(
              color: Colors.white,
            )),
        actions: [
          IconButton(
            onPressed: () async {
              var db = FirebaseFirestore.instance;
              await db.collection('api').doc('v1').collection('user').add(
                    _myuser.toJson(firebaseUser!.uid),
                  );
              Navigator.pushNamed(context, MyPageScreen.routeName);
            },
            icon: const Icon(
              Icons.check,
              size: 30,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
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
            margin: EdgeInsets.only(left: 15),
            child: Text('名前'),
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: TextFormField(
              maxLines: 1,
              maxLength: 25,
              onChanged: (val) {
                setState(() {
                  _myuser.setUserName = val;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text('Twitter'),
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: TextFormField(
              maxLines: 1,
              maxLength: 25,
              onChanged: (val) {
                setState(() {
                  _myuser.setTwitterLink = val;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text('github'),
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: TextFormField(
              maxLines: 1,
              maxLength: 25,
              onChanged: (val) {
                setState(() {
                  _myuser.setGithubAccount = val;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text('自己紹介'),
          ),
          Container(
            margin: EdgeInsets.all(
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
                setState(() {
                  _myuser.setSelfIntroduction = val;
                });
              },
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
