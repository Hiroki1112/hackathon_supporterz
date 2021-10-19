import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/helper/firebase_helper.dart';
import 'package:hackathon_supporterz/models/user.dart';
import 'package:hackathon_supporterz/screens/404/not_found.dart';
import 'package:hackathon_supporterz/screens/my_page/profile/mypage_top.dart';
import 'package:hackathon_supporterz/screens/my_page/profile_edit.dart';
import 'package:hackathon_supporterz/screens/my_page/sns_buttons.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({
    Key? key,
    required this.userId,
  }) : super(key: key);
  final String userId;

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool editButtonPresence = false;
  AsyncMemoizer<DocumentSnapshot<Map<String, dynamic>>> memo = AsyncMemoizer();

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    return FutureBuilder(
      future:
          memo.runOnce(() async => FirebaseHelper.getUserInfo(widget.userId)),
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          // ユーザーが存在しなかった場合はNotFoundを表示する
          if (!snapshot.data!.exists) {
            debugPrint('UserProfile class : user not found');
            return const NotFoundScreen();
          }
          MyUser _user = MyUser();
          _user.fromJson(snapshot.data!.data() ?? _user.toJson());
          if (firebaseUser != null) {
            if (firebaseUser.uid == _user.firebaseId) {
              editButtonPresence = true;
            }
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MypageTop(
                pictureURL: '',
                username: _user.useName,
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
                  _user.selfIntroduction,
                  textAlign: TextAlign.start,
                  style: const TextStyle(),
                ),
              ),
              editButtonPresence
                  ? Container(
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
                                  arguments: snapshot.data,
                                );
                                //await fetchData(firebaseUser);
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
                    )
                  : Container(),
              SNSButtons(
                twitterLink: _user.twitterLink,
                githubLink: _user.githubAccount,
              ),
            ],
          );
        }

        return Center(
          child: Column(
            children: const [
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}
