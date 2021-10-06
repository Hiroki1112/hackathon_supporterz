// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/models/post.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hackathon_supporterz/models/user.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:markdown/markdown.dart' as markdown;

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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // モバイルの場合は表示(true)にする
        automaticallyImplyLeading: !kIsWeb,
        title: Text("プロフィールを編集"),
        actions: [
          IconButton(
            onPressed: () {
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
          Container(
            margin: EdgeInsets.only(
              top: 25,
            ),
            child: Icon(
              Icons.people_outline,
              size: 100,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 60),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'プロフィール写真の変更',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: HexColor('#71D1D3'),
                  fontSize: 20,
                ),
              ),
            ),
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
                  _myuser.userName = val;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text('自己紹介'),
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: TextFormField(
              maxLines: 5,
              maxLength: 150,
              onChanged: (val) {
                setState(() {
                  _myuser.selfIntroduction = val;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
