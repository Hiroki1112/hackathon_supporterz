import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class MypageTop extends StatefulWidget {
  const MypageTop({
    Key? key,
    required this.pictureURL,
    required this.username,
  }) : super(key: key);

  final String pictureURL;
  final String username;

  @override
  _MypageTopState createState() => _MypageTopState();
}

class _MypageTopState extends State<MypageTop> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.pictureURL != ''
              ? const Icon(
                  //アイコンのURLを表示できるようにする
                  Icons.people_outline,
                  size: 130,
                )
              : Container(
                  padding: const EdgeInsetsDirectional.only(
                    top: 15,
                  ),
                  width: 100,
                  height: 100,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      firebaseUser!.photoURL ?? '',
                    ),
                  ),
                ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'My Follow',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              widget.username != ''
                  ? Text(
                      widget.username,
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    )
                  : const Text(
                      'widgednoName',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
