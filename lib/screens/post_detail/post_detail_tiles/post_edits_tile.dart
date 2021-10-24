import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/helper/firebase_helper.dart';
import 'package:jiffy/models/user.dart';
import 'package:jiffy/screens/404/not_found.dart';
import 'package:jiffy/screens/my_page/profile_edit.dart';
import 'package:provider/src/provider.dart';

class PostEditsTile extends StatefulWidget {
  const PostEditsTile({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;
  @override
  _PostEditsTileState createState() => _PostEditsTileState();
}

class _PostEditsTileState extends State<PostEditsTile> {
  bool isEditButton = false;
  AsyncMemoizer<DocumentSnapshot<Map<String, dynamic>>> memo = AsyncMemoizer();
  MyUser _user = MyUser();
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
          if (!snapshot.data!.exists) {
            return const NotFoundScreen();
          }

          _user.fromJson(snapshot.data!.data() ?? _user.toJson());
          if (firebaseUser != null) {
            if (firebaseUser.uid == _user.firebaseId) {
              isEditButton = true;
            }
          }
          //print(firebaseUser.toString());
          //print(isEditButton);
          return isEditButton
              ? Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 23,
                  ),
                  child: Wrap(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            // await Navigator.pushNamed(
                            //   context,
                            //   ProfileEdit.routeName,
                            // );
                            //await fetchData(firebaseUser);
                            //setState(() {});
                          },
                          child: const Text(
                            '記事の編集',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container();
        }
        return Container();
      },
    );
  }
}
