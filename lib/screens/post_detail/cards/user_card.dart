import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/helper/firebase_helper.dart';
import 'package:jiffy/models/user.dart';
import 'package:jiffy/util/app_theme.dart';
import 'package:jiffy/util/config.dart';

class UserCard extends StatefulWidget {
  const UserCard({
    Key? key,
    required this.userId,
  }) : super(key: key);
  final String userId;

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  var db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: AppTheme.white,
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
      child: FutureBuilder(
          future: FirebaseHelper.getUserInfo(widget.userId),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // ユーザーデータを受け取る
              MyUser _user = MyUser();

              if (snapshot.data!.data() == null) {
                return const Text('データの取得に失敗しました');
              }

              _user.fromJson(snapshot.data?.data() ?? {});

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/' + _user.userId,
                  );
                },
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(_user.pictureURL),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            _user.useName,
                            style: Config.h3,
                          ),
                        ),
                        Text(
                          _user.selfIntroduction,
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
