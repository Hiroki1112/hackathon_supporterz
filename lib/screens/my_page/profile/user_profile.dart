import 'package:async/async.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/helper/firebase_helper.dart';
import 'package:hackathon_supporterz/models/user.dart';
import 'package:hackathon_supporterz/screens/my_page/profile/mypage_top.dart';
import 'package:hackathon_supporterz/screens/my_page/profile_edit.dart';
import 'package:hackathon_supporterz/screens/my_page/sns_buttons.dart';
import 'package:provider/src/provider.dart';

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
  AsyncMemoizer<MyUser> memo = AsyncMemoizer();

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    return FutureBuilder(
      future:
          memo.runOnce(() async => FirebaseHelper.getUserInfo(widget.userId)),
      builder: (BuildContext context, AsyncSnapshot<MyUser> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MypageTop(
                pictureURL: '',
                username: snapshot.data?.useName ?? '',
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
                  snapshot.data?.selfIntroduction ?? '',
                  textAlign: TextAlign.start,
                  style: const TextStyle(),
                ),
              ),
              firebaseUser!.uid == snapshot.data!.firebaseId
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
                twitterLink: snapshot.data?.twitterLink ?? '',
                githubLink: snapshot.data?.githubAccount ?? '',
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
