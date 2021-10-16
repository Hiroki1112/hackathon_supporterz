import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/models/user.dart';

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
    var user =
        db.collection('api').doc('v1').collection('users').doc(widget.userId);
    return Card(
      child: FutureBuilder(
          future: user.get(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // ユーザーデータを受け取る
              MyUser _user = MyUser();

              if (snapshot.data!.data() == null) {
                return const Text('データの取得に失敗しました');
              }

              _user.fromJson(snapshot.data!.data() ?? {});

              return Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7.0,
                    ),
                    child: const Icon(
                      Icons.people,
                    ),
                  ),
                  Text(
                    _user.useName,
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              );
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
