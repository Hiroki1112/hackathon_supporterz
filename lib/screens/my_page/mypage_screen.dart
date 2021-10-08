import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackathon_supporterz/models/user.dart';
import 'package:hackathon_supporterz/screens/my_page/mypage_top.dart';
import 'package:hackathon_supporterz/screens/my_page/profile_edit.dart';
import 'package:hackathon_supporterz/screens/my_page/sns_buttons.dart';
import 'package:hackathon_supporterz/screens/post_screen/post_screen.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:hackathon_supporterz/widgets/tiles/post_tile.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class MyPageScreen extends StatefulWidget {
  static String routeName = '/mypage';
  const MyPageScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    var db = FirebaseFirestore.instance;
    DocumentReference<Map<String, dynamic>> user = db
        .collection('api')
        .doc('v1')
        .collection('user')
        .doc(firebaseUser!.uid);

    return FutureBuilder(
      future: user.get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          print("ERROR");
          print(snapshot.error.toString());
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          MyUser _myUser = MyUser();
          Map<String, dynamic> map;
          print(snapshot.hasData);
          print(snapshot.data);
          //print(snapshot.requi
          if (snapshot != null) {
            map = snapshot.requireData.data() as Map<String, dynamic>;
          } else {
            map = {};
          }

          _myUser.fromJson(map);

          return Scaffold(
            body: ListView(
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
                  child: Text(
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
                    style: TextStyle(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 23,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ProfileEdit.routeName);
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 5),
                      child: Text(
                        'プロフィール編集',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SNSButtons(
                  twitterLink: _myUser.twitterLink,
                  githubLink: _myUser.githubAccount,
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
                      PostTile(
                        simplePost: SimplePost(
                          'JavaScript to Java tte niteruyone',
                          'user hogehoge',
                          '#Flutter',
                        ),
                      ),
                      PostTile(
                        simplePost: SimplePost(
                          'JavaScript to Java tte niteruyone',
                          'user hogehoge',
                          '#Flutter',
                        ),
                      ),
                      PostTile(
                        simplePost: SimplePost(
                          'JavaScript to Java tte niteruyone',
                          'user hogehoge',
                          '#Flutter',
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }
}
